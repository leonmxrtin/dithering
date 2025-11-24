function floyd_img = floyd_color(img)
  % We work in the L*a*b* color space
  floyd_img = rgb2lab(img);
  
  % Iterate from top to bottom row, left to right pixels
  for y = 1:H,
    for x = 1:W,
      % Read pixel value
      oldpixel = reshape(floyd_img(y, x, :), 1, 3);
      
      newpixel = find_closest_palette_color(oldpixel);
      
      % Quantization error
      error = oldpixel - newpixel;
      
      % Replace pixel value
      floyd_img(y, x, :) = newpixel;
      
      % Out of bounds error would happen when x=1, x=W or y=H
      if (x < W)
        floyd_img(y, x+1, :) += reshape(error * 7/16, 1, 1, 3);
      endif
      if (y < H)
        floyd_img(y+1, x, :) += reshape(error * 5/16, 1, 1, 3);
      endif
      if (x > 1 && y < H)
        floyd_img(y+1, x-1, :) += reshape(error * 3/16, 1, 1, 3);
      endif
      if (x < W && y < H)
        floyd_img(y+1, x+1, :) += reshape(error * 1/16, 1, 1, 3);
      endif
    endfor
  endfor
  
  % Convert back to RGB for display
  floyd_img = lab2rgb(floyd_img);
endfunction