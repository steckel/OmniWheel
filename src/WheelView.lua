module("WheelView", package.seeall);

local Subject = require("observable.subject");
local TextureGrid = require("TextureGrid");
local WheelGeometry = require("WheelGeometry");
local WheelGraphics = require("WheelGraphics");
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
  -- FIXME(steckel): Inject GetScreenWidth and GetScreenHeight values
  self.frame:SetWidth(GetScreenWidth());
  self.frame:SetHeight(GetScreenHeight());
  self.frame:SetPoint("CENTER",0,0);
  -- Mouse Tracking
  self.previous_x = 0;
  self.previous_y = 0;
  -- Wheel Geometry
  self.wheel_geometry = WheelGeometry:New();
  -- Event Handling
  self.event_subject = Subject:New()
  -- background
  self.background = self.frame:CreateTexture(nil,"BACKGROUND");
  self.background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
  self.background:SetAllPoints(self.frame);
  -- wheel frame
  self.wheel_frame = self.frame:CreateTexture(nil,"ARTWORK");
  self.wheel_frame:SetSize(512, 512);
  self.wheel_frame:SetTexture("Interface\\AddOns\\OmniWheel\\textures\\8a_frame_center.tga");
  self.wheel_frame:SetPoint("CENTER", self.frame, "CENTER");
  self.wheel_frame:SetAlpha(0.7);
  -- highlight
  self.highlight_texture_grid = TextureGrid:New(self.frame);
  -- TODO(steckel): Remove this initial test call of SetAllTextures
  self:ShowWheelSectorHighlight(EightSector.ONE);
  self.wheel_graphics = WheelGraphics:New(self.frame, self.wheel_geometry);
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
  self:ShowWheelSectorHighlight(eight_sector);
  self.event_subject:Next({type = "ON_SECTOR_HOVER", data = eight_sector})
end

function WheelView:Observe()
  return self.event_subject:Observe()
end

function WheelView:Show()
  self.frame:Show();
  self.frame:SetScript("OnUpdate", function() self:OnFrameUpdate() end);
  self.event_subject:Next({type = "ON_SHOW"})
end

function WheelView:Hide()
  self.frame:Hide();
  self.frame:SetScript("OnUpdate", nil);
  self.event_subject:Next({type = "ON_HIDE"})
end

function WheelView:ShowWheelSectorHighlight(eight_sector)
  if eight_sector then
    self.highlight_texture_grid:SetAllTextures(
      sector_grid_images[eight_sector]);
    self.highlight_texture_grid:Show();
  else
    self.highlight_texture_grid:Hide();
  end
end

return WheelView;
