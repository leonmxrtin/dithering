function jarvis_img = jarvis(img)
  % Initialize output
  jarvis_img = img;
  
  % Iterate from top to bottom row, left to right pixels
  for y = 1:H,
    for x = 1:W,
      % Read pixel value
      oldpixel = jarvis_img(y, x);
      
      % Quantization: lesson 1 formula
      % Two levels = black and white (0, 1); Three levels = black, grey, white (0, 0.5, 1)...
      levels = 2;
      newpixel = round(oldpixel * (levels - 1)) / (levels - 1);
      
      % Quantization error
      error = oldpixel - newpixel;
      
      % Replace pixel value
      jarvis_img(y, x) = newpixel;
      
      % Out of bounds error would happen on pixels near the edges (range of two)
      if (x < W)
        jarvis_img(y, x+1) += error * 7/48;
      endif
      if (y < H)
        jarvis_img(y+1, x) += error * 7/48;
      endif
      if (x < W - 1)
        jarvis_img(y, x+2) += error * 5/48;
      endif
      if (x < W && y < H)
        jarvis_img(y+1, x+1) += error * 5/48;
      endif
      if (y < H - 1)
        jarvis_img(y+2, x) += error * 5/48;
      endif
      if (x > 1 && y < H)
        jarvis_img(y+1, x-1) += error * 5/48;
      endif
      if (x < W - 1 && y < H)
        jarvis_img(y+1, x+2) += error * 3/48;
      endif
      if (x < W && y < H - 1)
        jarvis_img(y+2, x+1) += error * 3/48;
      endif
      if (x > 1 && y < H - 1)
        jarvis_img(y+2, x-1) += error * 3/48;
      endif
      if (x > 2 && y < H)
        jarvis_img(y+1, x-2) += error * 3/48;
      endif
      if (x > 2 && y < H - 1)
        jarvis_img(y+2, x-2) += error * 1/48;
      endif
      if (x < W - 1 && y < H - 1)
        jarvis_img(y+2, x+2) += error * 1/48;
      endif
    endfor
  endfor
endfunction