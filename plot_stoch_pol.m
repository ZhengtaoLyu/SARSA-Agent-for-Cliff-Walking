function plot_stoch_pol(cpol,ngr,ngc,nact,B,G,cliff)
    % polt_pol Visualisation of the policy
    % Quiver plot of the actions that have largest probability and a plot line
    % plot of the optimal path for the policy
    
    % first convert from policy as cumulative distribution to a probability
    % distribution
    pol = cpol - cat(3,zeros(ngr,ngc,1),cpol(:,:,1:3));
    % obtain the actions that have maximum probability
    [~, D]=max(pol,[],3);
    
    % plot these actions as arrows on the grid
    
    [X, Y] = meshgrid(1:ngc,1:ngr);
    
    % coordinates for arrows (note the vertical axis is flipped later)
    T = [0 -1; % up
        0  1; % down
        -1  0; % left
        1  0 ];% right
    
    % plot arrows
    for k = 1:nact
        P = T(k,1).*pol(:,:,k);
        Q = T(k,2).*pol(:,:,k);
        quiver(X, Y, P, Q, 0.4, 'LineWidth', 2);
        hold on
    end
    
    % tidy up the plot
    axis ij;
    axis([0.5 ngc+0.5 0.5 ngr+0.5]);
    pbaspect([ngc ngr 1]);
    xticks(0.5:1:ngc+0.5)
    yticks(0.5:1:ngr+0.5)
    grid on
    set(gca,'Yticklabel',[])
    set(gca,'Xticklabel',[])
    title('Policy')
    
    % find the most likely path
    term = false;
    i = 0;
    S = B;
    path_x = [S(2)];
    path_y = [S(1)];
    
    while term == false
        i = i + 1;
        A = D(S(1),S(2));
        [S,~,term] = next_state(S,A,ngr,ngc,G,cliff);
        path_x = [path_x; S(2)];
        path_y = [path_y; S(1)];
    
        if i == (ngr*ngc)
            term = true;
            disp('Unable to find a terminating path')
        end
    end
    
    % plot the optimal path
    path_fig = figure;
    plot(path_x,path_y,'r','LineWidth',5);
    title('Most likely path')
    % tidy up the plot
    axis ij;
    axis([1 ngc 1 ngr]);
    pbaspect([ngc ngr 1]);
end