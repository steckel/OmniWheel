module("WheelGraphics", package.seeall);

local NewSector = require("Sector");

WheelGraphics = {}
WheelGraphics.__index = WheelGraphics;

function WheelGraphics:New(parent_frame, --[[WheelGeometry ]]wheel_geometry)
  local self = setmetatable({}, WheelViewRenderer);

  -- TODO(steckel): Inject this.
  local ui_scale = parent_frame:GetEffectiveScale();
  local distance_from_center = 90;
  local icon_size = 36;

  -- Sector 1
  self.sector_one_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_one_texture:SetSize(icon_size, icon_size);
  self.sector_one_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", distance_from_center / ui_scale, 0);
  self.sector_one_texture:SetTexture("Interface\\ICONS\\INV_Misc_Map_01.blp");
  local sector_one_texture_mask = parent_frame:CreateMaskTexture();
  sector_one_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_one_texture_mask:SetSize(32, 32);
  sector_one_texture_mask:SetPoint("CENTER", self.sector_one_texture, "CENTER");
  self.sector_one_texture:AddMaskTexture(sector_one_texture_mask);
  self.sector_one_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_one_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_one_font:SetPoint("LEFT", self.sector_one_texture, "CENTER", 30, 0);
  self.sector_one_font:SetText("MAP");

  -- Sector 2
  local bisecting_radius_sector_2 = wheel_geometry.sectors[2].sector:GetBisectingRadius();
  local sector_two_x, sector_two_y =
    polar_to_cartesian(bisecting_radius_sector_2, distance_from_center);
  self.sector_two_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_two_texture:SetSize(icon_size, icon_size);
  self.sector_two_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_two_x / ui_scale, sector_two_y / ui_scale);
  self.sector_two_texture:SetTexture("Interface\\ICONS\\INV_Misc_Book_09.blp");
  local sector_two_texture_mask = parent_frame:CreateMaskTexture();
  sector_two_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_two_texture_mask:SetSize(32, 32);
  sector_two_texture_mask:SetPoint("CENTER", self.sector_two_texture, "CENTER");
  self.sector_two_texture:AddMaskTexture(sector_two_texture_mask);
  self.sector_two_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_two_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_two_font:SetPoint("BOTTOMLEFT", self.sector_two_texture, "CENTER", 0, 30);
  self.sector_two_font:SetText("SPELL BOOK");

  -- Sector 3
  local bisecting_radius_sector_3 = wheel_geometry.sectors[3].sector:GetBisectingRadius();
  local sector_three_x, sector_three_y =
    polar_to_cartesian(bisecting_radius_sector_3, distance_from_center);
  self.sector_three_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_three_texture:SetSize(icon_size, icon_size);
  self.sector_three_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_three_x / ui_scale, sector_three_y / ui_scale);
  self.sector_three_texture:SetTexture("Interface\\ICONS\\INV_Misc_Book_08.blp");
  local sector_three_texture_mask = parent_frame:CreateMaskTexture();
  sector_three_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_three_texture_mask:SetSize(32, 32);
  sector_three_texture_mask:SetPoint("CENTER", self.sector_three_texture, "CENTER");
  self.sector_three_texture:AddMaskTexture(sector_three_texture_mask);
  self.sector_three_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_three_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_three_font:SetPoint("BOTTOM", self.sector_three_texture, "CENTER", 0, 30);
  self.sector_three_font:SetText("QUEST LOG");

  -- Sector 4
  local bisecting_radius_sector_4 = wheel_geometry.sectors[4].sector:GetBisectingRadius();
  local sector_four_x, sector_four_y =
    polar_to_cartesian(bisecting_radius_sector_4, distance_from_center);
  self.sector_four_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_four_texture:SetSize(icon_size, icon_size);
  self.sector_four_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_four_x / ui_scale, sector_four_y / ui_scale);
  self.sector_four_texture:SetTexture("Interface\\ICONS\\Ability_Marksmanship.blp");
  local sector_four_texture_mask = parent_frame:CreateMaskTexture();
  sector_four_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_four_texture_mask:SetSize(32, 32);
  sector_four_texture_mask:SetPoint("CENTER", self.sector_four_texture, "CENTER");
  self.sector_four_texture:AddMaskTexture(sector_four_texture_mask);
  self.sector_four_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_four_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_four_font:SetPoint("BOTTOMRIGHT", self.sector_four_texture, "CENTER", 0, 30);
  self.sector_four_font:SetText("TALENTS");

  -- Sector 5
  self.sector_five_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_five_texture:SetSize(32, 32);
  self.sector_five_texture:SetPoint("CENTER", parent_frame, "CENTER", -distance_from_center / ui_scale, 0);
  SetPortraitTexture(self.sector_five_texture, "player");
  self.sector_five_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_five_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_five_font:SetPoint("RIGHT", self.sector_five_texture, "CENTER", -30, 0);
  self.sector_five_font:SetText("CHARACTER");

  -- Sector 6
  local bisecting_radius_sector_6 = wheel_geometry.sectors[6].sector:GetBisectingRadius();
  local sector_six_x, sector_six_y =
    polar_to_cartesian(bisecting_radius_sector_6, distance_from_center);
  self.sector_six_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_six_texture:SetSize(icon_size, icon_size);
  self.sector_six_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_six_x / ui_scale, sector_six_y / ui_scale);
  self.sector_six_texture:SetTexture("Interface\\ICONS\\UI_Chat.blp");
  local sector_six_texture_mask = parent_frame:CreateMaskTexture();
  sector_six_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_six_texture_mask:SetSize(32, 32);
  sector_six_texture_mask:SetPoint("CENTER", self.sector_six_texture, "CENTER");
  self.sector_six_texture:AddMaskTexture(sector_six_texture_mask);
  self.sector_six_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_six_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_six_font:SetPoint("TOPRIGHT", self.sector_six_texture, "CENTER", 0, -30);
  self.sector_six_font:SetText("SOCIAL");

  -- Sector 7
  local bisecting_radius_sector_7 = wheel_geometry.sectors[7].sector:GetBisectingRadius();
  local sector_seven_x, sector_seven_y =
    polar_to_cartesian(bisecting_radius_sector_7, distance_from_center);
  self.sector_seven_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_seven_texture:SetSize(icon_size, icon_size);
  self.sector_seven_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_seven_x / ui_scale, sector_seven_y / ui_scale);
  self.sector_seven_texture:SetTexture("Interface\\ICONS\\INV_Misc_Bag_08.blp");
  local sector_seven_texture_mask = parent_frame:CreateMaskTexture();
  sector_seven_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_seven_texture_mask:SetSize(32, 32);
  sector_seven_texture_mask:SetPoint("CENTER", self.sector_seven_texture, "CENTER");
  self.sector_seven_texture:AddMaskTexture(sector_seven_texture_mask);
  self.sector_seven_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_seven_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_seven_font:SetPoint("TOP", self.sector_seven_texture, "CENTER", 0, -30);
  self.sector_seven_font:SetText("ALL BAGS");

  -- Sector 8
  local bisecting_radius_sector_8 = wheel_geometry.sectors[8].sector:GetBisectingRadius();
  local sector_eight_x, sector_eight_y =
    polar_to_cartesian(bisecting_radius_sector_8, distance_from_center);
  self.sector_eight_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_eight_texture:SetSize(icon_size, icon_size);
  self.sector_eight_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_eight_x / ui_scale, sector_eight_y / ui_scale);
  self.sector_eight_texture:SetTexture("Interface\\ICONS\\Mail_GMIcon.blp");
  local sector_eight_texture_mask = parent_frame:CreateMaskTexture();
  sector_eight_texture_mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  sector_eight_texture_mask:SetSize(32, 32);
  sector_eight_texture_mask:SetPoint("CENTER", self.sector_eight_texture, "CENTER");
  self.sector_eight_texture:AddMaskTexture(sector_eight_texture_mask);
  self.sector_eight_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_eight_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_eight_font:SetPoint("TOPLEFT", self.sector_eight_texture, "CENTER", 0, -30);
  self.sector_eight_font:SetText("REQUEST HELP");

  return self;
end

return WheelGraphics;
