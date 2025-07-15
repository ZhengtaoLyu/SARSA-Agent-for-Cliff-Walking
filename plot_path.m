function plot_path(S,Sp,ngr,ngc,term,i)
    %plot_path Plot the path of the current episode
    fig = plot([S(2) Sp(2)],[S(1) Sp(1)],'r','LineWidth',5);
    axis ij;
    axis([0.5 ngc+0.5 0.5 ngr+0.5]);
    pbaspect([ngc ngr 1]);
    xticks(0.5:1:ngc+0.5)
    yticks(0.5:1:ngr+0.5)
    grid on
    set(gca,'Yticklabel',[])
    set(gca,'Xticklabel',[])
    title(i)
    hold on;
    point = plot(Sp(2),Sp(1),'b.',MarkerSize=30);
    hold on;
    pause(0.1);
    fig.Color(4) = 0.2;
    delete(point);
    if term == true
        hold off;
    end

end