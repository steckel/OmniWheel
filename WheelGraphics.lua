export("WheelGraphics", function()

local NewSector = require("Sector");

WheelGraphics = {}
WheelGraphics.__index = WheelGraphics;

function WheelGraphics:New(parent_frame, --[[WheelGeometry ]]wheel_geometry)
  local self = setmetatable({}, WheelViewRenderer);

  -- TODO(steckel): Inject this.
  local ui_scale = parent_frame:GetEffectiveScale();
  local distance_from_center = 90;

  -- Sector 1
  self.sector_one_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_one_texture:SetHeight(32);
  self.sector_one_texture:SetWidth(32);
  self.sector_one_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", distance_from_center / ui_scale, 0);
  self.sector_one_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_one_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_one_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_one_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_one_font:SetJustifyH("LEFT");
  self.sector_one_font:SetPoint("LEFT", self.sector_one_texture, "RIGHT", 10 / ui_scale, 0);
  self.sector_one_font:SetText("MAP");
  -- Sector 2
  local bisecting_radius_sector_2 = wheel_geometry.sectors[2].sector:GetBisectingRadius();
  local sector_two_x, sector_two_y =
    polar_to_cartesian(bisecting_radius_sector_2, distance_from_center);
  self.sector_two_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_two_texture:SetHeight(32);
  self.sector_two_texture:SetWidth(32);
  self.sector_two_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_two_x / ui_scale, sector_two_y / ui_scale);
  self.sector_two_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_two_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_two_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_two_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_two_font:SetJustifyH("LEFT");
  local sector_two_font_x, sector_two_font_y =
    polar_to_cartesian(bisecting_radius_sector_2, 30);
  self.sector_two_font:SetPoint("BOTTOM", self.sector_two_texture, "CENTER", sector_two_font_x / ui_scale, sector_two_font_y / ui_scale);
  self.sector_two_font:SetText("SPELL BOOK");

  -- Sector 3
  local bisecting_radius_sector_3 = wheel_geometry.sectors[3].sector:GetBisectingRadius();
  local sector_three_x, sector_three_y =
    polar_to_cartesian(bisecting_radius_sector_3, distance_from_center);
  self.sector_three_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_three_texture:SetHeight(32);
  self.sector_three_texture:SetWidth(32);
  self.sector_three_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_three_x / ui_scale, sector_three_y / ui_scale);
  self.sector_three_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_three_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_three_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_three_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_three_font:SetJustifyH("LEFT");
  local sector_three_font_x, sector_three_font_y =
    polar_to_cartesian(bisecting_radius_sector_3, 30);
  self.sector_three_font:SetPoint("BOTTOM", self.sector_three_texture, "CENTER", sector_three_font_x / ui_scale, sector_three_font_y / ui_scale);
  self.sector_three_font:SetText("QUEST LOG");

  -- Sector 4
  local bisecting_radius_sector_4 = wheel_geometry.sectors[4].sector:GetBisectingRadius();
  local sector_four_x, sector_four_y =
    polar_to_cartesian(bisecting_radius_sector_4, distance_from_center);
  self.sector_four_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_four_texture:SetHeight(32);
  self.sector_four_texture:SetWidth(32);
  self.sector_four_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_four_x / ui_scale, sector_four_y / ui_scale);
  self.sector_four_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_four_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_four_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_four_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_four_font:SetJustifyH("LEFT");
  local sector_four_font_x, sector_four_font_y =
    polar_to_cartesian(bisecting_radius_sector_4, 30);
  self.sector_four_font:SetPoint("BOTTOM", self.sector_four_texture, "CENTER", sector_four_font_x / ui_scale, sector_four_font_y / ui_scale);
  self.sector_four_font:SetText("TALENTS");

  -- Sector 5
  self.sector_five_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_five_texture:SetHeight(32);
  self.sector_five_texture:SetWidth(32);
  self.sector_five_texture:SetPoint("CENTER", parent_frame, "CENTER", -distance_from_center / ui_scale, 0);
  SetPortraitTexture(self.sector_five_texture, "player");
  self.sector_five_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_five_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_five_font:SetJustifyH("RIGHT");
  self.sector_five_font:SetPoint("RIGHT", self.sector_five_texture, "LEFT", -10 / ui_scale, 0);
  self.sector_five_font:SetText("CHARACTER");

  -- Sector 6
  local bisecting_radius_sector_6 = wheel_geometry.sectors[6].sector:GetBisectingRadius();
  local sector_six_x, sector_six_y =
    polar_to_cartesian(bisecting_radius_sector_6, distance_from_center);
  self.sector_six_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_six_texture:SetHeight(32);
  self.sector_six_texture:SetWidth(32);
  self.sector_six_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_six_x / ui_scale, sector_six_y / ui_scale);
  self.sector_six_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_six_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_six_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_six_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_six_font:SetJustifyH("LEFT");
  local sector_six_font_x, sector_six_font_y =
    polar_to_cartesian(bisecting_radius_sector_6, 30);
  self.sector_six_font:SetPoint("TOP", self.sector_six_texture, "CENTER", sector_six_font_x / ui_scale, sector_six_font_y / ui_scale);
  self.sector_six_font:SetText("SOCIAL");

  -- Sector 7
  local bisecting_radius_sector_7 = wheel_geometry.sectors[7].sector:GetBisectingRadius();
  local sector_seven_x, sector_seven_y =
    polar_to_cartesian(bisecting_radius_sector_7, distance_from_center);
  self.sector_seven_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_seven_texture:SetHeight(32);
  self.sector_seven_texture:SetWidth(32);
  self.sector_seven_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_seven_x / ui_scale, sector_seven_y / ui_scale);
  self.sector_seven_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_seven_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_seven_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_seven_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_seven_font:SetJustifyH("CENTER");
  local sector_seven_font_x, sector_seven_font_y =
    polar_to_cartesian(bisecting_radius_sector_7, 30);
  self.sector_seven_font:SetPoint("TOP", self.sector_seven_texture, "CENTER", sector_seven_font_x / ui_scale, sector_seven_font_y / ui_scale);
  self.sector_seven_font:SetText("ALL BAGS");

  -- Sector 8
  local bisecting_radius_sector_8 = wheel_geometry.sectors[8].sector:GetBisectingRadius();
  local sector_eight_x, sector_eight_y =
    polar_to_cartesian(bisecting_radius_sector_8, distance_from_center);
  self.sector_eight_texture = parent_frame:CreateTexture(nil, "ARTWORK");
  self.sector_eight_texture:SetHeight(32);
  self.sector_eight_texture:SetWidth(32);
  self.sector_eight_texture:SetPoint(
    "CENTER", parent_frame, "CENTER", sector_eight_x / ui_scale, sector_eight_y / ui_scale);
  self.sector_eight_texture:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  self.sector_eight_texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
  self.sector_eight_font = parent_frame:CreateFontString(nil, "ARTWORK");
  self.sector_eight_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.sector_eight_font:SetJustifyH("RIGHT");
  local sector_eight_font_x, sector_eight_font_y =
    polar_to_cartesian(bisecting_radius_sector_8, 30);
  self.sector_eight_font:SetPoint("TOP", self.sector_eight_texture, "CENTER", sector_eight_font_x / ui_scale, sector_eight_font_y / ui_scale);
  self.sector_eight_font:SetText("REQUEST HELP");

  return self;
end

return WheelGraphics;

end);
