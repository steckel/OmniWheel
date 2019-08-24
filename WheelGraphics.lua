WheelGraphics = {}
WheelGraphics.__index = WheelGraphics;

function WheelGraphics:New(parent_frame)
  local self = setmetatable({}, WheelViewRenderer);

  local ui_scale = parent_frame:GetEffectiveScale();

  local img1 = parent_frame:CreateTexture(nil, "ARTWORK")
  img1:SetHeight(32)
  img1:SetWidth(32)
  img1:SetPoint("RIGHT", parent_frame, "CENTER", -75 / ui_scale, 0)
  SetPortraitTexture(img1, "player")

  self.center_left_font = parent_frame:CreateFontString(nil, "ARTWORK")
  self.center_left_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  self.center_left_font:SetJustifyH("RIGHT")
  self.center_left_font:SetPoint("RIGHT", img1, "LEFT", -10 / ui_scale, 0);
  self.center_left_font:SetText("CHARACTER")

  local img2 = parent_frame:CreateTexture(nil, "ARTWORK")
  img2:SetHeight(32)
  img2:SetWidth(32)
  img2:SetPoint("LEFT", parent_frame, "CENTER", 75 / ui_scale, 0)
  img2:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
  img2:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");

  local right_font = parent_frame:CreateFontString(nil, "ARTWORK")
  right_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
  right_font:SetJustifyH("RIGHT")
  right_font:SetPoint("LEFT", img2, "RIGHT", 10 / ui_scale, 0);
  right_font:SetText("SPELL BOOK")

  return self;
end
