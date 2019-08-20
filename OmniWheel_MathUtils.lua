function pythag(a, b)
  return math.sqrt((a ^ 2) + (b ^ 2));
end

function slope(x1, y1, x2, y2)
  return (y2 - y1) / (x2 - x1);
end

function radian_from_degree(angle)
  return angle * math.pi / 180;
end

function degrees_from_radians(radians)
  return radians * (180/math.pi);
end
