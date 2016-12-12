function [] = main(imname, dof, iterations)
im = imread(imname);
imshow(im);
hold on;
[~, y] = ginput(2);
hold off;
midy = (y(1) + y(2)) / 2;
dofTop = round(midy - dof / 2);
dofBottom = round(midy + dof / 2);
h = size(im, 1);
w = size(im, 2);
masks = zeros(h, w, iterations);
stacksr = zeros(h, w, iterations);
stacksg = zeros(h, w, iterations);
stacksb = zeros(h, w, iterations);
width = round(bigger(dofTop, size(im, 1) - dofBottom) / iterations);
resultr = zeros(size(im, 1), size(im, 2));
resultg = zeros(size(im, 1), size(im, 2));
resultb = zeros(size(im, 1), size(im, 2));
filter = gaussian2d(1);
for a = 1:iterations
   upperl = dofTop - (a - 1) * width;
   if upperl > 0
       upperu = upperl - width + 1;
       if upperu < 1
           upperu = 1;
       end
       masks(upperu : upperl, :, a) = ones(upperl - upperu + 1, w, 1);
   end
   loweru = dofBottom + (a - 1) * width;
   if loweru < h
       lowerl = loweru + width - 1;
       if lowerl > h
           lowerl = h;
       end
       masks(loweru : lowerl, :, a) = ones(lowerl - loweru + 1, w, 1);       
   end
%    stacksr(:, :, a) = myGaussFilt(im(:, :, 1), maxSigma / (iterations - a + 1));
%    stacksg(:, :, a) = myGaussFilt(im(:, :, 2), maxSigma / (iterations - a + 1));
%    stacksb(:, :, a) = myGaussFilt(im(:, :, 3), maxSigma / (iterations - a + 1));
   stacksr(:, :, a) = conv2(double(im(:, :, 1)), filter, 'same');
   stacksg(:, :, a) = conv2(double(im(:, :, 2)), filter, 'same');
   stacksb(:, :, a) = conv2(double(im(:, :, 3)), filter, 'same'); 
   filter = conv2(filter, gaussian2d(2), 'full');
   resultr = resultr + masks(:, :, a) .* stacksr(:, :, a);
   resultg = resultg + masks(:, :, a) .* stacksg(:, :, a);
   resultb = resultb + masks(:, :, a) .* stacksb(:, :, a);
end
result = cat(3, resultr, resultg, resultb);
result(dofTop : dofBottom, :) = im(dofTop : dofBottom, :);
result = uint8(result);
imghsv = rgb2hsv(result);
imghsv(:, :, 2) = imghsv(:, :, 2) * 1.4;
result = hsv2rgb(imghsv);
imshow(result);
imwrite(result, 'eblurred.jpg');
end

function [c] = bigger(a, b)
if a > b
    c = a;
else
    c = b;
end
end

% function [f]= myGaussFilt(img, sigma)
% f = conv2(double(img), gaussian2d(sigma), 'same');
% end

function [f] = gaussian2d(sigma)
N = sigma * 2;
[x, y] = meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
f = exp(-x.^2/(2*sigma^2) - y.^2 / (2*sigma^2));
f = f ./ sum(f(:));
end