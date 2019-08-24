local THREE_SIXTY = 360;

WheelGeometry = {};
WheelGeometry.__index = WheelGeometry;

---
-- @param {int} number_of_sectors
-- @param {int} offset_angle - initial sector radius offset in degrees
function WheelGeometry:New(number_of_sectors, offset_angle)
  -- TODO: verify offset_angle is 0—359
  local self = setmetatable({}, WheelGeometry);
  self.sectors = BuildUniformSectors(number_of_sectors, offset_angle);
  return self;
end

---
-- @param {int} wheel_center_x
-- @param {int} wheel_center_y
-- @param {int} x
-- @param {int} y
-- @return {int}
function WheelGeometry:GetSectorAtPoint(wheel_center_x, wheel_center_y, x, y)
    local angle = math.atan2(y - wheel_center_y, x - wheel_center_x);
    angle = angle > 0 and angle or radian_from_degree(360) + angle;

    for key, record in pairs(self.sectors) do
      local sector = record.sector;
      if (sector:Contains(angle)) then
        return key.
      end
    end

    -- TODO: throw rather than return nil
    return nil;
end

-- @param {int} number_of_sectors
-- @param {int} offset_angle - initial sector radius offset in degrees
-- @return {table<int, Sector>}
function BuildUniformSectors(number_of_sectors, offset_angle)
  local table = {};
  local sector_size = THREE_SIXTY / number_of_sectors;
  for i in number_of_sectors do
    local start_angle = i * sector_size + offset_angle;
    table[i] = Sector:New(sector_size, start_angle);
  end
  return table;
end

