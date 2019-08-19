-- Meta class
Circle = {};
Circle.__index = Circle;

-- Base class method new
function Circle:New(x, y, diameter)
  local self = setmetatable({}, Circle)
  self.x = x
  self.y = y
  self.diameter = diameter
  return self
end

function Circle:GetRadius()
  return self.diameter / 2;
end

function Circle:GetCenter()
  return self.x + self:GetRadius(), self.y + self:GetRadius();
end

function Circle:ContainsPoint(x, y)
  local center_x, center_y = self:GetCenter();
  return (((x - center_x) ^ 2) + ((y - center_y) ^ 2)) < (self:GetRadius() ^ 2);
end
