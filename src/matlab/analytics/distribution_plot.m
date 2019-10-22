function distribution_plot(lh,title_suffix)
%DISTRIBUTION_PLOT Illustrate distributions of defect dimension given in lh
    
    if nargin==1
        title_suffix = '';
    else
        title_suffix = strcat(" ",title_suffix);
    end
    
    log_lh = log(lh);
    
    max_length = 8;
    max_height = 6;

    % Length
    figure('Position',[0 50 900 300]);
    histogram(log_lh(:,1),0:0.1:max_length);
    % histfit(log_lh(:,1));
    xlim([0 8]);
    title(strcat('Length distribution',title_suffix));
    xlabel('Length (log)');
    
    % Height
    histogram(log_lh(:,2),0:0.1:max_height);
    % histfit(log_lh(:,2));
    xlim([0 6]);
    title(strcat('Height distribution',title_suffix));
    xlabel('Height (log)');
    ylabel('Number of regions');
    
    % Plot gaussian distribution of log(lh)
    
    mu = mean(log_lh);
    sigma = cov(log_lh);
    
    x1 = 0:0.01:max_length;
    x2 = 0:0.01:max_height;
    
    [X1,X2] = meshgrid(x1,x2);
    X = [X1(:) X2(:)];

    y = mvnpdf(X,mu,sigma);
    y = reshape(y,length(x2),length(x1));

    figure('Position',[0 50 400 400]);
    imshow(y,'XData',x1,'YData',x2,'DisplayRange',[min(min(y)) max(max(y))],'ColorMap',parula(256));
    colorbar;
    % surf(x1,x2,y);
    axis on;
    xlabel('Length (log)')
    ylabel('Height (log)')
    title(strcat('Probability density',title_suffix))

end

