module("WheelGeometry", package.seeall);

local NewSector = require("Sector");

local THREE_SIXTY = 360;

WheelGeometry = {};
WheelGeometry.__index = WheelGeometry;

function WheelGeometry:New()
  local self = setmetatable({}, WheelGeometry);
  -- Sectors
  -- FIXME(steckel): Just make the EightSector the key
  self.sectors = {
    { sector = NewSector:New(45, 337.5), eight_sector = EightSector.ONE },
    { sector = NewSector:New(45, 22.5), eight_sector = EightSector.TWO },
    { sector = NewSector:New(45, 67.5), eight_sector = EightSector.THREE },
    { sector = NewSector:New(45, 112.5), eight_sector = EightSector.FOUR },
    { sector = NewSector:New(45, 157.5), eight_sector = EightSector.FIVE },
    { sector = NewSector:New(45, 202.5), eight_sector = EightSector.SIX },
    { sector = NewSector:New(45, 247.5), eight_sector = EightSector.SEVEN },
    { sector = NewSector:New(45, 292.5), eight_sector = EightSector.EIGHT },
  };
  return self;
end

function WheelGeometry:GetSector(eight_sector)
  -- FIXME(steckel): This just so happens to work, but it's not necessarily
  -- indexed by EightSector yet.
  return self.sectors[eight_sector].sector;
end

function WheelGeometry:GetSectorAtPoint(center_x, center_y, x, y)
  local normalized_x = x - center_x;
  local normalized_y = y - center_y;
  local distance = math.sqrt(normalized_x^2 + normalized_y ^ 2);
  if distance < 50 then
    return nil
  end

  local angle = math.atan2(normalized_y, normalized_x);
  angle = angle > 0 and angle or radian_from_degree(THREE_SIXTY) + angle;
  for key, value in pairs(self.sectors) do
    local sector = value.sector;
    local eight_sector = value.eight_sector;
    if (sector:Contains(angle)) then
      return eight_sector;
    end
  end
  -- FIXME(steckel): make more better
  error("Should always return a sector...");
end
---
-- @param {int} number_of_sectors
-- @param {int} offset_angle - initial sector radius offset in degrees
-- function WheelGeometry:New(number_of_sectors, offset_angle)
--   -- TODO: verify offset_angle is 0—359
--   local self = setmetatable({}, WheelGeometry);
--   self.sectors = BuildUniformSectors(number_of_sectors, offset_angle);
--   return self;
-- end

---
-- @param {int} wheel_center_x
-- @param {int} wheel_center_y
-- @param {int} x
-- @param {int} y
-- @return {int}
-- function WheelGeometry:GetSectorAtPoint(wheel_center_x, wheel_center_y, x, y)
--     local angle = math.atan2(y - wheel_center_y, x - wheel_center_x);
--     angle = angle > 0 and angle or radian_from_degree(360) + angle;
-- 
--     for key, record in pairs(self.sectors) do
--       local sector = record.sector;
--       if (sector:Contains(angle)) then
--         return key.
--       end
--     end
-- 
--     -- TODO: throw rather than return nil
--     return nil;
-- end

-- @param {int} number_of_sectors
-- @param {int} offset_angle - initial sector radius offset in degrees
-- @return {table<int, Sector>}
-- function BuildUniformSectors(number_of_sectors, offset_angle)
--   local table = {};
--   local sector_size = THREE_SIXTY / number_of_sectors;
--   for i in number_of_sectors do
--     local start_angle = i * sector_size + offset_angle;
--     table[i] = Sector:New(sector_size, start_angle);
--   end
--   return table;
-- end

return WheelGeometry;
