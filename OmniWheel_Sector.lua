-- Meta class
-- http://mathworld.wolfram.com/CircularSector.html
-- https://www.geeksforgeeks.org/check-whether-point-exists-circle-sector-not/
-- https://stackoverflow.com/questions/13652518/efficiently-find-points-inside-a-circle-sector
-- https://www.quora.com/How-do-I-find-whether-a-point-lies-in-the-sector-of-a-circle-or-not
Sector = { start_angle = 0, central_angle = 0 }

function Sector:New(start_angle, central_angle)
  local sector = {};
  setmetatable(sector, self);
  self.__index = self;
  self.start_angle = start_angle
  self.central_angle = central_angle
  return sector;
end

function Sector:GetStartRadiusSlope()
  return math.tan(radian_from_degree(self.start_angle));
end

function Sector:GetEndRadiusSlope()
  return math.tan(radian_from_degree(self.start_angle + self.central_angle));
end
