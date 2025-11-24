function palette_color = find_closest_palette_color(original_color)
  % Extracted from ACeP library
  color_list_rgb = [
    0 0 0 % black
    255 255 255 % white
    67 138 28 % green
    100 64 255 % blue/purple
    191 0 0 % red
    255 243 56 % yellow
    232 126 0 % orange
  ];
  
  color_list = rgb2lab(double(color_list_rgb / 255));

  % Convert all needed values to L*a*b*
  distance_list = color_list - original_color;

  % For each (l, a, b) row, calculate l^2 + a^2 + b^2
  % We only want to compare the distances, not calculate the value, so no need to take the square root
  distances = sum(distance_list.^2, 2);

  [~, min_index] = min(distances);
  palette_color = color_list(min_index, :);
endfunction