module("WheelView", package.seeall);

local EventTarget = require("EventTarget");
local WheelGeometry = require("WheelGeometry");
local WheelViewRenderer = require("WheelViewRenderer");
---
-- WheelView is similar to a View in the MVC architecture.
-- WheelView is the interface for the application to express wheel state.
WheelView = {}
WheelView.__index = WheelView;

function WheelView:New(uiparent)
  local self = setmetatable({}, WheelView);
  local ui_scale = uiparent:GetEffectiveScale();

  self.frame = CreateFrame("Frame", nil, uiparent);
  self.frame:Hide();
  self.frame:SetScale(1 / ui_scale);
  self.frame:SetFrameStrata("FULLSCREEN");
  -- NOTE(steckel): Do we need ui_scale here?
  --local ui_scale = parent_frame:GetEffectiveScale();
  --self.frame:SetScale(1 / ui_scale);
  -- FIXME(steckel): Inject GetScreenWidth and GetScreenHeight values
  self.frame:SetWidth(GetScreenWidth());
  self.frame:SetHeight(GetScreenHeight());
  self.frame:SetPoint("CENTER",0,0);
  -- self.frame:EnableMouse(true);
  -- Mouse Tracking
  self.previous_x = 0;
  self.previous_y = 0;
  -- Wheel Geometry
  self.wheel_geometry = WheelGeometry:New();
  -- Texture Rendering
  self.renderer = WheelViewRenderer:New(
    self.frame, --[[kinda like the model for now]]self.wheel_geometry);
  -- Event Handling
  self.event_target = EventTarget:New({"ON_SHOW", "ON_HIDE", "ON_SECTOR_HOVER" });
  return self;
end

function WheelView:OnFrameUpdate()
  -- FIXME(steckel): Inject these globals.
  local ui_scale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition();
  -- FIXME(steckel): Gota to trim these values
  if (x ~= self.previous_x or y ~= self.previous_y) then
    self:OnCursorMove(x, y);
  end
end

function WheelView:OnCursorMove(cursor_x, cursor_y)
  local center_x, center_y = self.frame:GetCenter();
  local eight_sector =
    self.wheel_geometry:GetSectorAtPoint(center_x, center_y, cursor_x, cursor_y);
  self.renderer:ShowWheelSectorHighlight(eight_sector);
  self.event_target:Trigger("ON_SECTOR_HOVER", eight_sector);
end

function WheelView:AddEventListener(event, fn, caller)
  self.event_target:AddEventListener(event, fn, caller);
end

function WheelView:Show()
  self.frame:Show();
  self.frame:SetScript("OnUpdate", function() self:OnFrameUpdate() end);
  self.event_target:Trigger("ON_SHOW");
end

function WheelView:Hide()
  self.frame:Hide();
  self.frame:SetScript("OnUpdate", nil);
  self.event_target:Trigger("ON_HIDE");
end

return WheelView;
