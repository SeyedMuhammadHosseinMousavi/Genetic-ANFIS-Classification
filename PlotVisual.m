function PlotVisual(targets,outputs,Name)
    errors=targets-outputs;
    MSE=mean(errors(:).^2);
    RMSE=sqrt(mean(errors(:).^2));
    error_mean=mean(errors(:));
    error_std=std(errors(:));
    

    plot(targets,'-.',...
    'LineWidth',1,...
    'MarkerSize',10,...
    'Color',[0.0,0.9,0.0]);
    hold on;
    plot(outputs,':',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'Color',[0.4,0.2,0.9]);
    legend('Target','Output');
    title(Name);
    grid on;
    title([' MSE= ' num2str(MSE),'     RMSE= ' num2str(RMSE),'     Error Mean = ' num2str(error_mean) '     Error STD = ' num2str(error_std)],...
        'FontSize',12,'FontWeight','bold','Color',[0.9,0.4,0.3]);
    
end