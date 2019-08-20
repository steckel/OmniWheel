-- Meta class
-- http://mathworld.wolfram.com/CircularSector.html
-- https://www.geeksforgeeks.org/check-whether-point-exists-circle-sector-not/
-- https://stackoverflow.com/questions/13652518/efficiently-find-points-inside-a-circle-sector
-- https://www.quora.com/How-do-I-find-whether-a-point-lies-in-the-sector-of-a-circle-or-not
Sector = {}
Sector.__index = Sector;

function Sector:New(start_angle, central_angle)
  local self = setmetatable({}, Sector);
  self.start_angle = start_angle
  self.central_angle = central_angle
  return self;
end

function Sector:GetStartRadiusSlope()
  return math.tan(radian_from_degree(self.start_angle));
end

function Sector:GetEndRadiusSlope()
  return math.tan(radian_from_degree(self.start_angle + self.central_angle));
end

NewSector = {};
NewSector.__index = NewSector;

function NewSector:New(central_angle, start_angle)
  local self = setmetatable({}, NewSector);
  self.central_angle = central_angle;
  self.start_angle = start_angle;
  return self;
end

function NewSector:Contains(angle)
  local start_angle = radian_from_degree(self.start_angle);
  local end_angle = self.start_angle + self.central_angle;
  if end_angle > 360 then
    end_angle = end_angle <= 360 and end_angle or end_angle - 360;
    end_angle = radian_from_degree(end_angle);
    return (angle > start_angle and angle < radian_from_degree(360)) and true or
      (angle > 0 and angle < end_angle) and true or false;
  else
    end_angle = radian_from_degree(end_angle);
    return angle > start_angle and angle < end_angle and true or false;
  end
end
