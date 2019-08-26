export("OmniWheelAddon", function()

local WheelController = require("WheelController");
local WheelView = require("WheelView");

-- OmniWheelAddon
OmniWheelAddon = {};
OmniWheelAddon.__index = OmniWheelAddon;

function OmniWheelAddon:New(uiparent)
  local self = setmetatable({}, OmniWheelAddon);
  local controller = WheelController:New();
  self.wheel_view = WheelView:New(uiparent);
  self.wheel_view:AddEventListener("ON_SECTOR_HOVER", controller.OnWheelSectorHover, controller);
  self.wheel_view:AddEventListener("ON_SHOW", controller.OnWheelShow, controller);
  self.wheel_view:AddEventListener("ON_HIDE", controller.OnWheelHide, controller);
  return self;
end

function OmniWheelAddon:ShowWheel()
  self.wheel_view:Show();
end

function OmniWheelAddon:HideWheel()
  self.wheel_view:Hide();
end

return OmniWheelAddon;

end);
