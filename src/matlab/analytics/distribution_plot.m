function distribution_plot(lh)
%DISTRIBUTION_PLOT Illustrate distributions of defect dimension given in lh

    % Length
    figure('Position',[0 50 900 300]);
    histogram(lh(:,1));
    title('Length distribution');
    xlabel('Length');
    ylabel('Number of regions');
    
    % Height
    figure('Position',[0 50 900 300]);
    histogram(lh(:,2));
    title('Height distribution');
    xlabel('Height');
    ylabel('Number of regions');
    
    % Plot gaussian distribution of log(lh)
    log_lh = log(lh);
    mu = mean(log_lh);
    sigma = cov(log_lh);
    
    x1 = 0:1:500;
    x2 = 0:1:256;
    [X1,X2] = meshgrid(x1,x2);
    X = [X1(:) X2(:)];

    y = mvnpdf(X,mu,sigma);
    y = reshape(y,length(x2),length(x1));

    figure('Position', [0 50 900 300]);
    imshow(y,'DisplayRange',[min(min(y)) max(max(y))],'ColorMap',parula(256));
    % surf(x1,x2,exp(y))
    % caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
    % axis([-800 800 -128 128 0 0.1])
    xlabel('x1')
    ylabel('x2')
    zlabel('Probability Density')
end

