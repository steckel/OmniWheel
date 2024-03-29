module("WheelViewRenderer", package.seeall);

local TextureGrid = require("TextureGrid");
local WheelGraphics = require("WheelGraphics");

---
-- WheelViewRenderer expresses WheelView state on a Frame with Graphics.
WheelViewRenderer = {}
WheelViewRenderer.__index = WheelViewRenderer;

function WheelViewRenderer:New(parent_frame, wheel_geometry)
  local self = setmetatable({}, WheelViewRenderer);
  -- background
  self.background = parent_frame:CreateTexture(nil,"BACKGROUND");
  self.background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
  self.background:SetAllPoints(self.frame);
  -- wheel frame
  self.wheel_frame = parent_frame:CreateTexture(nil,"ARTWORK");
  self.wheel_frame:SetSize(512, 512);
  self.wheel_frame:SetTexture("Interface\\AddOns\\OmniWheel\\textures\\8a_frame_center.tga");
  self.wheel_frame:SetPoint("CENTER", self.frame, "CENTER");
  self.wheel_frame:SetAlpha(0.7);
  -- highlight
  self.highlight_texture_grid = TextureGrid:New(parent_frame);
  -- TODO(steckel): Remove this initial test call of SetAllTextures
  self:ShowWheelSectorHighlight(EightSector.ONE);
  self.wheel_graphics = WheelGraphics:New(parent_frame, wheel_geometry);
  return self;
end

function WheelViewRenderer:ShowWheelSectorHighlight(eight_sector)
  if eight_sector then
    self.highlight_texture_grid:SetAllTextures(
      sector_grid_images[eight_sector]);
    self.highlight_texture_grid:Show();
  else
    self.highlight_texture_grid:Hide();
  end
end

function WheelViewRenderer:SetWheelSectorGraphics(sector_id, label, texture_path)
end

return WheelViewRenderer;
