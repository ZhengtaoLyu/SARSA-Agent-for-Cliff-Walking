function [Sp,R,term] = next_state(S,A,ngr,ngc,G,cliff)
    %Determine the next state
    % evaluate new state from the action - since we will change at most one
    % coordinate we'll start by setting both coordinates of the next
    % state Sp equal to those of S. An action that would result in
    % leaving the grid will leave the state unchanged.
    
    Sp = S;
    if A == 1
        % move up
        % but can't move up in top row
        if S(1) ~= 1
            Sp(1) = S(1) - 1;
        end

    elseif A == 2
        % move down
        % but can't move down in bottom row
        if S(1) ~= ngr
            Sp(1) = S(1) + 1;
        end

    elseif A == 3
        % move left
        % but can't move left in 1st column
        if S(2) ~= 1
            Sp(2) = S(2) - 1;
        end

    elseif A == 4
        % move right
        % but can't move right in last column
        if S(2) ~= ngc
            Sp(2) = S(2) + 1;
        end
    end


    % evaluate the rewards and check if we are now in a terminal state
    if isequal(Sp,G)
        % reached goal
        R=-1;
        term = true;
    elseif find(cliff(:,1) == Sp(1) & cliff(:, 2) == Sp(2),1)
        % fallen off cliff, go back to start
        R=-100;
        term = true;
    else
        % still in the main grid
        R=-1;
        term = false;
    end

end