clc;
clear;
close all;

% define algorithm parameters
alpha = 0.5;
gamma = 1;
epsilon = 0.1;

% plot path? turn off to speed up!
path = false;

% specify the number of episodes
N = 10000;

% define the number of grid rows, number of grid columns, number of actions
ngr=5;
ngc=9;
nact=4;

%%% Initialise Q(s,a) arbitrarily
Q = zeros(ngr,ngc,nact);

% the policy is initialised to equal probabilities of 0.25 for all actions
pol = (1/nact).*ones(ngr,ngc,nact);

% for convenience the policy is stored as a cumulative probability
% distribution over actions 1 to 4 (i.e. sum over dimension 3 of p)
cpol = cumsum(pol,3);

% define the cliff states
Y = 3.*ones(6,1);
X = (2:7)';
cliff = [Y X];

% initialise next state array
Sp = [0 0];

% set the start state
B = [5 1];

% set the goal state
G = [1 5];

% record return per episode
rets = zeros(N,1);


%%% Repeat for each episode
for i = 1:N

    %%% Initialise S
    % begin in the start state
    S = B;

    %%% Choose A from S using policy derived from Q
    % generate a uniform random number in (0,1)
    r = rand;

    % find the interval of the cumulative distribution in which r falls to
    % determine the action
    A = find((cpol(S(1),S(2),:)-r)>0,1); 

    % we want to keep going unless in a terminal state; the goal and cliff
    % will be defined as terminal states
    term = false;

    %%% Repeat for each step of episode

    % reset episode return
    ret = 0;

    while term == false

        %%% Take action A, observe Sp and R
        [Sp,R,term] = next_state(S,A,ngr,ngc,G,cliff);

        %%% Choose Ap from Sp using ploicy derived from Q
        r=rand;
        Ap = find((cpol(Sp(1),Sp(2),:) - r > 0),1);

        %%% Update Q
        % value is 0 if in a terminal state: this is already set by
        % initialisation of Q to zero and the fact that Q will never be
        % updated for a terminal state
        Q(S(1),S(2),A) = Q(S(1),S(2),A) + alpha * (R + (gamma * Q(Sp(1),Sp(2),Ap)) - Q(S(1),S(2),A));

        % update policy from Q for state S (eps-greedy) by
        % finding the maximum value across actions and find the
        % corresponding maximal aciton(s)
        % note we may have more than one optimal action, so we'll choose
        % one at random
        M = max(Q(S(1),S(2),:));
        argmaxa = find(Q(S(1),S(2),:) == M);
        a = argmaxa(randi(length(argmaxa)));

        % assign epsilon-greedy probabilities
        % first initialise all probabilities to epsilon/4
        pol=(epsilon/nact).*ones(1,nact);

        % then the optimal action is assigned the remaining probability
        pol(a) = 1 - (nact-1)*epsilon/nact;

        % update the policy as a cumulative distribution
        cpol(S(1),S(2),:) = cumsum(pol);

        % plot path
        if path == true
            plot_path(S,Sp,ngr,ngc,term,i)  
        end

        %%% Update S
        S=Sp;

        %%% Apdate A
        A=Ap;
      
        % accumulate rewards for episode return
        ret = ret + R;

    end

    % record episode return
    rets(i) = ret;

end

% visualise the policy by plotting the actions that have maximum
% probability and plot the most likely path
plot_stoch_pol(cpol,ngr,ngc,nact,B,G,cliff);

% plot of return per episode
figure;
plot(rets);
title('Returns per episode')
