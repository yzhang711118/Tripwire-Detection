function out1 = processImage(fileName)

    % ExamineFile(fileName)
    % Input: (fileName): the full path of the image file.  A character array.
    % Return: (H): the Hough transform.  An array of doubles.
    %


    if nargin ~= 1
        disp('  Error:One argument must be specified.');
        help processImage;
        out1 = [];
        return;
    end

    imgNum = fileName(end-7:end-4);

    %Opens the image from the file and converts to grayscale
    colorImg = imread(fileName);
    %     figure, imshow(colorImg,'InitialMagnification','fit'),...
    %         title("Color"), hold on
     
    
    grayImg = rgb2gray(colorImg);

    %     figure, imshow(grayImg,'InitialMagnification','fit'),...
    %         title("Gray"), hold on



%     % Applies a gradient sigmoid filter
%    gradSigImg = gradSigmoidFilter(grayImg,2);
%    figure, imshow(gradSigImg,'InitialMagnification','fit'),...
%        title("Gradient Sigmoid"), hold on
    
%    imgSize = size(gradSigImg);
    
%   cropImg = gradSigImg(5:(imgSize(1)-5), 5:(imgSize(2)-5));
%    cropImg = imcrop(gradSigImg,[0,0,280,220]);
%     
      % Edge Detection
%     edgeImg = edge(cropImg, 'Canny');
%      figure, imshow(edgeImg,'InitialMagnification','fit'),...
%        title("Edge"), hold on
% % 


%%%%% Gradient Subtraction Method %%%%%
    imgSize = size(grayImg);
    
    cropImg = grayImg(5:(imgSize(1)-5), 5:(imgSize(2)-5));
    %cropImg = imcrop(grayImg,[0,0,280,220]);

    [GxDouble,GyDouble] = imgradientxy(cropImg);
    GyUINT = uint8(GyDouble);
    [GxGyDouble,GyGyDouble] = imgradientxy(GyUINT);
    GyGyUINT = uint8(GyGyDouble);

    diffImg = imsubtract((GyUINT),GyGyUINT);

    edgeImg = edge(grayImg,'canny');
%%%%% Gradient Subtraction METHOD %%%%%



    % Hough Transform
    [H,theta,rho]=hough(edgeImg,'Theta',[-90:0.1:-85,85:0.1:89.5]);   
    peak=houghpeaks(H,1); %Threshold value must be determined experimentally
    x=theta(peak(:,2));
    y=rho(peak(:,1));



    % Display Line
    lines = houghlines(edgeImg,theta,rho,peak,'FillGap',10,'MinLength',10);
    figure, imshow(colorImg,'InitialMagnification','fit'),...
        title(imgNum), hold on
    max_len = 0;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
   end
    
   %  figure;
   %  %subplot(2,1,2);
   %  imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,...
   %          'InitialMagnification', 'fit'); 
   %  title('Hough transform of original');
   %  xlabel('\theta'),ylabel('\rho');
   %  axis on, axis normal,hold on;
   %  %colormap(gca,hot);
   %  plot(x,y,'s','color','blue');
    

    out1 = H;
end
    