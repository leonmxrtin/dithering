function floyd_img = floyd(img)
  % Initialize output
  floyd_img = img
  
  % Iterate from top to bottom row, left to right pixels
  for y = 1:H,
    for x = 1:W, 
      % Read pixel value
      oldpixel = floyd_img(y, x);
      
      % Quantization: lesson 1 formula
      % Two levels = black and white (0, 1); Three levels = black, grey, white (0, 0.5, 1)...
      levels = 2;
      newpixel = round(oldpixel * (levels - 1)) / (levels - 1);
      
      % Quantization error
      error = oldpixel - newpixel;
      
      % Replace pixel value
      floyd_img(y, x) = newpixel;
      
      % Out of bounds error would happen when x=1, x=W or y=H
      if (x < W)
        floyd_img(y, x+1) += error * 7/16;
      endif 
      if (y < H)
        floyd_img(y+1, x) += error * 5/16;
      endif 
      if (x > 1 && y < H)
        floyd_img(y+1, x-1) += error * 3/16;
      endif 
      if (x < W && y < H)
        floyd_img(y+1, x+1) += error * 1/16;
      endif 
    endfor 
  endfor
endfunction