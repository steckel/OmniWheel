module("OmniWheelAddon", package.seeall);

local WheelController = require("WheelController");
local WheelView = require("WheelView");

-- OmniWheelAddon
OmniWheelAddon = {};
OmniWheelAddon.__index = OmniWheelAddon;

function OmniWheelAddon:New(uiparent)
  local self = setmetatable({}, OmniWheelAddon);
  local controller = WheelController:New();
  self.wheel_view = WheelView:New(uiparent);

  self.wheel_view
    :Observe()
    :Filter(function(event) return event.type == "ON_SECTOR_HOVER" end)
    :Map(function(event) return event.data end)
    :Subscribe(bind(controller.OnWheelSectorHover, controller))

  self.wheel_view
    :Observe()
    :Filter(function(event) return event.type == "On_SHOW" end)
    :Subscribe(bind(controller.OnWheelShow, controlller))

  self.wheel_view
    :Observe()
    :Filter(function(event) return event.type == "ON_HIDE" end)
    :Subscribe(bind(controller.OnWheelHide, controller))

  return self;
end

function OmniWheelAddon:ShowWheel()
  self.wheel_view:Show();
end

function OmniWheelAddon:HideWheel()
  self.wheel_view:Hide();
end

return OmniWheelAddon;
