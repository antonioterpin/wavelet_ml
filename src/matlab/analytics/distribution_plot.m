function distribution_plot(lh,title_suffix,use_log)
%DISTRIBUTION_PLOT Illustrate distributions of defect dimension given in lh
    
    if nargin==1
        title_suffix = '';
    elseif nargin >= 2
        title_suffix = strcat(" ",title_suffix);
    end
    
    if nargin < 3
        use_log = true;
    end
    
    assert(nargin < 4, "Wrong number of parameters");
    
    log_lh = log(lh);
    
    max_length = 8;
    max_height = 6;
    
    data = lh;
    if use_log
        data = log_lh;
    end

    % Length
    
    figure('Position',[0 50 900 300]);
    histogram(data(:,1),0:0.1:max_length);
    % histfit(data(:,1));
    xlim([0 8]);
    title(strcat('Length distribution',title_suffix));
    xlabel('Length (log)');
    
    % Height
    histogram(data(:,2),0:0.1:max_height);
    % histfit(data(:,2));
    xlim([0 6]);
    title(strcat('Height distribution',title_suffix));
    xlabel('Height (log)');
    ylabel('Number of regions');
    
    if use_log
       % Plot gaussian distribution of log(lh)
    
        mu = mean(data);
        sigma = cov(data);

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
        
        % Probability plot
        figure('Position',[0 50 400 400]);
        probplot(data(:,1));
        title(strcat('Length probability plot',title_suffix));
        figure('Position',[0 50 400 400]);
        probplot(data(:,2));
        title(strcat('Height probability plot',title_suffix));
    end

end

