function jarvis_img = jarvis_color(img)
  % We work in the L*a*b* color space
  jarvis_img = rgb2lab(img);
  
  % Iterate from top to bottom row, left to right pixels
  for y = 1:H,
    for x = 1:W,
      % Read pixel value
      oldpixel = reshape(jarvis_img(y, x, :), 1, 3);
      
      newpixel = find_closest_palette_color(oldpixel);
      
      % Quantization error
      error = oldpixel - newpixel;
      
      % Replace pixel value
      jarvis_img(y, x, :) = newpixel;
      
      % Out of bounds error would happen on pixels near the edges (range of two)
      if (x < W)
        jarvis_img(y, x+1, :) += reshape(error * 7/48, 1, 1, 3);
      endif
      if (y < H)
        jarvis_img(y+1, x, :) += reshape(error * 7/48, 1, 1, 3);
      endif
      if (x < W - 1)
        jarvis_img(y, x+2, :) += reshape(error * 5/48, 1, 1, 3);
      endif
      if (x < W && y < H)
        jarvis_img(y+1, x+1, :) += reshape(error * 5/48, 1, 1, 3);
      endif
      if (y < H - 1)
        jarvis_img(y+2, x, :) += reshape(error * 5/48, 1, 1, 3);
      endif
      if (x > 1 && y < H)
        jarvis_img(y+1, x-1, :) += reshape(error * 5/48, 1, 1, 3);
      endif
      if (x < W - 1 && y < H)
        jarvis_img(y+1, x+2, :) += reshape(error * 3/48, 1, 1, 3);
      endif
      if (x < W && y < H - 1)
        jarvis_img(y+2, x+1, :) += reshape(error * 3/48, 1, 1, 3);
      endif
      if (x > 1 && y < H - 1)
        jarvis_img(y+2, x-1, :) += reshape(error * 3/48, 1, 1, 3);
      endif
      if (x > 2 && y < H)
        jarvis_img(y+1, x-2, :) += reshape(error * 3/48, 1, 1, 3);
      endif
      if (x > 2 && y < H - 1)
        jarvis_img(y+2, x-2, :) += reshape(error * 1/48, 1, 1, 3);
      endif
      if (x < W - 1 && y < H - 1)
        jarvis_img(y+2, x+2, :) += reshape(error * 1/48, 1, 1, 3);
      endif
    endfor
  endfor
  
  % Convert back to RGB for display
  jarvis_img = lab2rgb(jarvis_img);
endfunction