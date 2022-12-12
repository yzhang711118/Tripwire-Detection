function out1 = gradSigmoidFilter(img, L)
% 
% REM0.0 SOA
% GradSig = gs(img,L)
% Calculate the thresholded GS filter on all sweeps of the Bscan BS.
% img    Image to be filtered
% L     Length of the filter kernel [default: 1/3 mean period]
%


if nargin < 1
    disp('  Error: at least one argument must be specified.');
    help gs;
    GradSig = [];
    return;
end

if nargin < 2
    L = 1;
end

if size(img,3)==3
    grayImg = rgb2gray(img);
elseif size(img,3) == 1
    grayImg = img;
end

doubleImg = double(grayImg);


% Convolution Kernal for GS Filter.
Q = [-ones(L,1); 0; +ones(L,1)];


% Filtered Image
A = convn(sign(gradient(doubleImg')'),Q, 'same');

out1 = A;

return