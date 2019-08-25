---
-- WheelViewRenderer expresses WheelView state on a Frame with Graphics.
WheelViewRenderer = {}
WheelViewRenderer.__index = WheelViewRenderer;

function WheelViewRenderer:New(parent_frame)
  local self = setmetatable({}, WheelViewRenderer);
  -- background
  self.background = parent_frame:CreateTexture(nil,"BACKGROUND");
  self.background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
  self.background:SetAllPoints(self.frame);
  -- wheel frame
  self.wheel_frame = parent_frame:CreateTexture(nil,"ARTWORK");
  self.wheel_frame:SetWidth(512);
  self.wheel_frame:SetHeight(512);
  self.wheel_frame:SetTexture("Interface\\AddOns\\OmniWheel\\textures\\8a_frame_center.tga");
  self.wheel_frame:SetPoint("CENTER", self.frame, "CENTER");
  -- highlight
  self.highlight_texture_grid = TextureGrid:New(parent_frame);
  -- TODO(steckel): Remove this initial test call of SetAllTextures
  self:ShowWheelSectorHighlight(EightSector.ONE);
  self.wheel_graphics = WheelGraphics:New(parent_frame);
  return self;
end

function WheelViewRenderer:ShowWheelSectorHighlight(eight_sector)
  self.highlight_texture_grid:SetAllTextures(
    sector_grid_images[eight_sector]);
end

function WheelViewRenderer:SetWheelSectorGraphics(sector_id, label, texture_path)
end
