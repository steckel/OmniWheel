export("TextureGrid", function()
--
-- TextureGrid
TextureGrid = {};
TextureGrid.__index = TextureGrid;

function TextureGrid:New(parent_frame)
  local self = setmetatable({}, TextureGrid);
  -- CENTER_RIGHT
  self.center_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.center_right:SetWidth(512);
  self.center_right:SetHeight(256);
  self.center_right:SetPoint("LEFT", parent_frame, "CENTER");
  -- CENTER_FAR_RIGHT
  self.center_far_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.center_far_right:SetWidth(512);
  self.center_far_right:SetHeight(256);
  self.center_far_right:SetPoint("LEFT", self.center_right, "RIGHT");
  -- TOP_RIGHT
  self.top_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.top_right:SetWidth(512);
  self.top_right:SetHeight(256);
  self.top_right:SetPoint("BOTTOM", self.center_right, "TOP");
  -- TOP_FAR_RIGHT
  self.top_far_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.top_far_right:SetWidth(512);
  self.top_far_right:SetHeight(256);
  self.top_far_right:SetPoint("LEFT", self.top_right, "RIGHT");
  -- TOP_LEFT
  self.top_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.top_left:SetWidth(512);
  self.top_left:SetHeight(256);
  self.top_left:SetPoint("RIGHT", self.top_right, "LEFT");
  -- TOP_FAR_LEFT
  self.top_far_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.top_far_left:SetWidth(512);
  self.top_far_left:SetHeight(256);
  self.top_far_left:SetPoint("RIGHT", self.top_left, "LEFT");
  -- CENTER_LEFT
  self.center_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.center_left:SetWidth(512);
  self.center_left:SetHeight(256);
  self.center_left:SetPoint("TOP", self.top_left, "BOTTOM");
  -- CENTER_FAR_LEFT
  self.center_far_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.center_far_left:SetWidth(512);
  self.center_far_left:SetHeight(256);
  self.center_far_left:SetPoint("RIGHT", self.center_left, "LEFT");
  -- BOTTOM_LEFT
  self.bottom_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.bottom_left:SetWidth(512);
  self.bottom_left:SetHeight(256);
  self.bottom_left:SetPoint("TOP", self.center_left, "BOTTOM");
  -- BOTTOM_FAR_LEFT
  self.bottom_far_left = parent_frame:CreateTexture(nil,"OVERLAY");
  self.bottom_far_left:SetWidth(512);
  self.bottom_far_left:SetHeight(256);
  self.bottom_far_left:SetPoint("RIGHT", self.bottom_left, "LEFT");
  -- BOTTOM_RIGHT
  self.bottom_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.bottom_right:SetWidth(512);
  self.bottom_right:SetHeight(256);
  self.bottom_right:SetPoint("LEFT", self.bottom_left, "RIGHT");
  -- BOTTOM_FAR_RIGHT
  self.bottom_far_right = parent_frame:CreateTexture(nil,"OVERLAY");
  self.bottom_far_right:SetWidth(512);
  self.bottom_far_right:SetHeight(256);
  self.bottom_far_right:SetPoint("LEFT", self.bottom_right, "RIGHT");
  return self;
end

function TextureGrid:SetAllTextures(grid_texture_paths)
  self.center_far_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.CENTER_FAR_RIGHT]);
  self.center_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.CENTER_RIGHT]);
  self.top_far_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.TOP_FAR_RIGHT]);
  self.top_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.TOP_RIGHT]);
  self.top_far_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.TOP_FAR_LEFT]);
  self.top_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.TOP_LEFT]);
  self.center_far_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.CENTER_FAR_LEFT]);
  self.center_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.CENTER_LEFT]);
  self.bottom_far_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.BOTTOM_FAR_LEFT]);
  self.bottom_left:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.BOTTOM_LEFT]);
  self.bottom_far_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.BOTTOM_FAR_RIGHT]);
  self.bottom_right:SetTexture(
    grid_texture_paths[HighlightOverlayGridSection.BOTTOM_RIGHT]);
end

return TextureGrid;

end);
