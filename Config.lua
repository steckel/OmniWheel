Config = {};
Config.__index = Config;

---
-- @param {Action} action
-- @param {Sector} sector
function Config:New(action, sector)
  local self = setmetatable({}, Config);
  self.action = action;
  self.sector = sector;
  return self;
end
