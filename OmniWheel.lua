local kTexturesDirectory = "Interface\\AddOns\\OmniWheel\\textures\\";

function GetHighlightTexture(eight_sector, grid)
  return kTexturesDirectory.."8a_sector_"..tostring(eight_sector).."_"..string.lower(grid)..".tga";
end

-- doesn't seem to work since SetTexture always returns true
function LoadGridTextures(sectors, sections)
  local table = {};
  local test_texture = CreateFrame("Frame"):CreateTexture();
  for key, value in pairs(sectors) do
    table[value] = {};
    for key2, value2 in pairs(sections) do
      local texture_path = GetHighlightTexture(value, value2);
      local loaded = test_texture:SetTexture(texture_path);
      table[value][value2] = loaded and texture_path or nil;
    end
  end
  return table;
end

local EightSector = {
  ONE = 1,
  TWO = 2,
  THREE = 3,
  FOUR = 4,
  FIVE = 5,
  SIX = 6,
  SEVEN = 7,
  EIGHT = 8
};

local HighlightOverlayGridSection = {
  BOTTOM_FAR_RIGHT = "BOTTOM_FAR_RIGHT",
  BOTTOM_RIGHT = "BOTTOM_RIGHT",
  CENTER_FAR_RIGHT = "CENTER_FAR_RIGHT",
  CENTER_RIGHT = "CENTER_RIGHT",
  TOP_FAR_RIGHT = "TOP_FAR_RIGHT",
  TOP_RIGHT = "TOP_RIGHT",
  BOTTOM_FAR_LEFT = "BOTTOM_FAR_LEFT",
  BOTTOM_LEFT = "BOTTOM_LEFT",
  CENTER_FAR_LEFT = "CENTER_FAR_LEFT",
  CENTER_LEFT = "CENTER_LEFT",
  TOP_FAR_LEFT = "TOP_FAR_LEFT",
  TOP_LEFT = "TOP_LEFT",
};

-- TODO: query for textures on boot...
local sector_grid_images = {
  [EightSector.ONE] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.BOTTOM_FAR_RIGHT),
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.BOTTOM_RIGHT),
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.CENTER_FAR_RIGHT),
    [HighlightOverlayGridSection.CENTER_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.CENTER_RIGHT),
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.TOP_FAR_RIGHT),
    [HighlightOverlayGridSection.TOP_RIGHT] = GetHighlightTexture(EightSector.ONE, HighlightOverlayGridSection.TOP_RIGHT),
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = nil,
  },
  [EightSector.TWO] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = GetHighlightTexture(EightSector.TWO, HighlightOverlayGridSection.CENTER_RIGHT),
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = GetHighlightTexture(EightSector.TWO, HighlightOverlayGridSection.TOP_FAR_RIGHT),
    [HighlightOverlayGridSection.TOP_RIGHT] = GetHighlightTexture(EightSector.TWO, HighlightOverlayGridSection.TOP_RIGHT),
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = nil,
  },
  [EightSector.THREE] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = GetHighlightTexture(EightSector.THREE, HighlightOverlayGridSection.CENTER_RIGHT),
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = GetHighlightTexture(EightSector.THREE, HighlightOverlayGridSection.TOP_RIGHT),
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = GetHighlightTexture(EightSector.THREE, HighlightOverlayGridSection.CENTER_LEFT),
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = GetHighlightTexture(EightSector.THREE, HighlightOverlayGridSection.TOP_LEFT),
  },
  [EightSector.FOUR] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = GetHighlightTexture(EightSector.FOUR, HighlightOverlayGridSection.CENTER_LEFT),
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = GetHighlightTexture(EightSector.FOUR, HighlightOverlayGridSection.TOP_FAR_LEFT),
    [HighlightOverlayGridSection.TOP_LEFT] = GetHighlightTexture(EightSector.FOUR, HighlightOverlayGridSection.TOP_LEFT),
  },
  [EightSector.FIVE] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.BOTTOM_FAR_LEFT),
    [HighlightOverlayGridSection.BOTTOM_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.BOTTOM_LEFT),
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.CENTER_FAR_LEFT),
    [HighlightOverlayGridSection.CENTER_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.CENTER_LEFT),
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.TOP_FAR_LEFT),
    [HighlightOverlayGridSection.TOP_LEFT] = GetHighlightTexture(EightSector.FIVE, HighlightOverlayGridSection.TOP_LEFT),
  },
  [EightSector.SIX] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = GetHighlightTexture(EightSector.SIX, HighlightOverlayGridSection.BOTTOM_FAR_LEFT),
    [HighlightOverlayGridSection.BOTTOM_LEFT] = GetHighlightTexture(EightSector.SIX, HighlightOverlayGridSection.BOTTOM_LEFT),
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = GetHighlightTexture(EightSector.SIX, HighlightOverlayGridSection.CENTER_LEFT),
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = nil,
  },
  [EightSector.SEVEN] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = GetHighlightTexture(EightSector.SEVEN, HighlightOverlayGridSection.BOTTOM_RIGHT),
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = GetHighlightTexture(EightSector.SEVEN, HighlightOverlayGridSection.CENTER_RIGHT),
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = GetHighlightTexture(EightSector.SEVEN, HighlightOverlayGridSection.BOTTOM_LEFT),
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = GetHighlightTexture(EightSector.SEVEN, HighlightOverlayGridSection.CENTER_LEFT),
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = nil,
  },
  [EightSector.EIGHT] = {
    [HighlightOverlayGridSection.BOTTOM_FAR_RIGHT] = GetHighlightTexture(EightSector.EIGHT, HighlightOverlayGridSection.BOTTOM_FAR_RIGHT),
    [HighlightOverlayGridSection.BOTTOM_RIGHT] = GetHighlightTexture(EightSector.EIGHT, HighlightOverlayGridSection.BOTTOM_RIGHT),
    [HighlightOverlayGridSection.CENTER_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.CENTER_RIGHT] = GetHighlightTexture(EightSector.EIGHT, HighlightOverlayGridSection.CENTER_RIGHT),
    [HighlightOverlayGridSection.TOP_FAR_RIGHT] = nil,
    [HighlightOverlayGridSection.TOP_RIGHT] = nil,
    [HighlightOverlayGridSection.BOTTOM_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.BOTTOM_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.CENTER_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_FAR_LEFT] = nil,
    [HighlightOverlayGridSection.TOP_LEFT] = nil,
  }
};

-- main
function main()

  function AddTestFontsToFrame(text, frame)
    -- local font_string = frame:CreateFontString(nil, "ARTWORK")
    -- font_string:SetPoint("TOPLEFT", frame, "TOPLEFT");
    -- font_string:SetFont("Fonts\\".."FRIZQT__.TTF", 16);
    -- font_string:SetJustifyH("LEFT")
    -- font_string:SetText(text);

    -- MY FAVORITE: "ARIALN.TTF", "THICKOUTLINE"
    local flags = {"OUTLINE", "THICKOUTLINE", "MONOCHROME",
                  "OUTLINE,THICKOUTLINE", "THICKOUTLINE,MONOCHROME", "OUTLINE,MONOCHROME",
                  "OUTLINE,THICKOUTLINE,MONOCHROME"};
    local fonts = {"ARIALN.TTF", "FRIZQT__.TTF", "MORPHEUS.TTF", "SKURRI.TTF"};
    local last_font;
    local last_font_row;
    for i, font in ipairs(fonts) do
      for j, flag in ipairs(flags) do
        print("i, j, font, flag", i, j, font, flag);
        local font_string = frame:CreateFontString(nil, "ARTWORK");
        font_string:SetFont("Fonts\\"..font, 16, flag);
        font_string:SetTextColor(0,0,0,1);
        font_string:SetJustifyH("LEFT")
        font_string:SetText(text);
        if i == 1 and j == 1 then
          font_string:SetPoint("TOPLEFT", frame, "TOPLEFT", 100, -300);
          last_font_row = font_string;
          last_font = font_string;
        elseif j == 1 then
          font_string:SetPoint("TOPLEFT", last_font_row, "BOTTOMLEFT", 0, -10);
          last_font_row = font_string;
          last_font = font_string;
        else
          font_string:SetPoint("LEFT", last_font, "RIGHT", 10, 0);
          last_font = font_string;
        end
      end
    end
  end

  HighlightOverlayGrid = {};
  HighlightOverlayGrid.__index = HighlightOverlayGrid;

  -- Base class method new
  function HighlightOverlayGrid:New(parent_frame)
    local ui_scale = parent_frame:GetEffectiveScale();
    local self = setmetatable({}, HighlightOverlayGrid)
    self.last_active_sector = nil;
    -- Frame
    self.frame = CreateFrame("Frame", nil, parent_frame);
    self.frame:SetScale(1 / ui_scale);
    self.frame:SetWidth(GetScreenWidth());
    self.frame:SetHeight(GetScreenHeight());
    self.frame:SetPoint("CENTER",0,0);
    -- Sectors
    self.sectors = {
      { sector = NewSector:New(45, 337.5), eight_sector = EightSector.ONE },
      { sector = NewSector:New(45, 22.5), eight_sector = EightSector.TWO },
      { sector = NewSector:New(45, 67.5), eight_sector = EightSector.THREE },
      { sector = NewSector:New(45, 112.5), eight_sector = EightSector.FOUR },
      { sector = NewSector:New(45, 157.5), eight_sector = EightSector.FIVE },
      { sector = NewSector:New(45, 202.5), eight_sector = EightSector.SIX },
      { sector = NewSector:New(45, 247.5), eight_sector = EightSector.SEVEN },
      { sector = NewSector:New(45, 292.5), eight_sector = EightSector.EIGHT },
    };
    local img1 = self.frame:CreateTexture(nil, "ARTWORK")
    img1:SetHeight(32)
    img1:SetWidth(32)
    img1:SetPoint("RIGHT", self.frame, "CENTER", -75 / ui_scale, 0)
    SetPortraitTexture(img1, "player")
    self.center_left_font = self.frame:CreateFontString(nil, "ARTWORK")
    self.center_left_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
    self.center_left_font:SetJustifyH("RIGHT")
    self.center_left_font:SetPoint("RIGHT", img1, "LEFT", -10 / ui_scale, 0);
    self.center_left_font:SetText("CHARACTER")

    local img2 = self.frame:CreateTexture(nil, "ARTWORK")
    img2:SetHeight(32)
    img2:SetWidth(32)
    img2:SetPoint("LEFT", self.frame, "CENTER", 75 / ui_scale, 0)
    img2:SetTexture("Interface\\SPELLBOOK\\Spellbook-Icon.blp");
    img2:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMaskSmall.blp");
    local right_font = self.frame:CreateFontString(nil, "ARTWORK")
    right_font:SetFont("Fonts\\ARIALN.TTF", 14, "THICKOUTLINE");
    right_font:SetJustifyH("RIGHT")
    right_font:SetPoint("LEFT", img2, "RIGHT", 10 / ui_scale, 0);
    right_font:SetText("SPELL BOOK")

    -- Inner Circle
    local inner_diameter = 100;
    local inner_x_offset = (GetScreenWidth() - inner_diameter) / 2;
    local inner_y_offset = (GetScreenHeight() - inner_diameter) / 2;
    self.inner_circle = Circle:New(inner_x_offset, inner_y_offset, 100);
    -- CENTER_RIGHT
    self.center_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.center_right:SetWidth(512);
    self.center_right:SetHeight(256);
    self.center_right:SetPoint("LEFT", self.frame, "CENTER");
    -- CENTER_FAR_RIGHT
    self.center_far_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.center_far_right:SetWidth(512);
    self.center_far_right:SetHeight(256);
    self.center_far_right:SetPoint("LEFT", self.center_right, "RIGHT");
    -- TOP_RIGHT
    self.top_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.top_right:SetWidth(512);
    self.top_right:SetHeight(256);
    self.top_right:SetPoint("BOTTOM", self.center_right, "TOP");
    -- TOP_FAR_RIGHT
    self.top_far_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.top_far_right:SetWidth(512);
    self.top_far_right:SetHeight(256);
    self.top_far_right:SetPoint("LEFT", self.top_right, "RIGHT");
    -- TOP_LEFT
    self.top_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.top_left:SetWidth(512);
    self.top_left:SetHeight(256);
    self.top_left:SetPoint("RIGHT", self.top_right, "LEFT");
    -- TOP_FAR_LEFT
    self.top_far_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.top_far_left:SetWidth(512);
    self.top_far_left:SetHeight(256);
    self.top_far_left:SetPoint("RIGHT", self.top_left, "LEFT");
    -- CENTER_LEFT
    self.center_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.center_left:SetWidth(512);
    self.center_left:SetHeight(256);
    self.center_left:SetPoint("TOP", self.top_left, "BOTTOM");
    -- CENTER_FAR_LEFT
    self.center_far_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.center_far_left:SetWidth(512);
    self.center_far_left:SetHeight(256);
    self.center_far_left:SetPoint("RIGHT", self.center_left, "LEFT");
    -- BOTTOM_LEFT
    self.bottom_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.bottom_left:SetWidth(512);
    self.bottom_left:SetHeight(256);
    self.bottom_left:SetPoint("TOP", self.center_left, "BOTTOM");
    -- BOTTOM_FAR_LEFT
    self.bottom_far_left = self.frame:CreateTexture(nil,"OVERLAY");
    self.bottom_far_left:SetWidth(512);
    self.bottom_far_left:SetHeight(256);
    self.bottom_far_left:SetPoint("RIGHT", self.bottom_left, "LEFT");
    -- BOTTOM_RIGHT
    self.bottom_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.bottom_right:SetWidth(512);
    self.bottom_right:SetHeight(256);
    self.bottom_right:SetPoint("LEFT", self.bottom_left, "RIGHT");
    -- BOTTOM_FAR_RIGHT
    self.bottom_far_right = self.frame:CreateTexture(nil,"OVERLAY");
    self.bottom_far_right:SetWidth(512);
    self.bottom_far_right:SetHeight(256);
    self.bottom_far_right:SetPoint("LEFT", self.bottom_right, "RIGHT");
    -- FRAME OUTLINE
    self.frame_outline = self.frame:CreateTexture(nil,"ARTWORK");
    self.frame_outline:SetWidth(512);
    self.frame_outline:SetHeight(512);
    self.frame_outline:SetTexture("Interface\\AddOns\\OmniWheel\\textures\\8a_frame_center.tga");
    self.frame_outline:SetPoint("CENTER", self.frame, "CENTER");

    return self
  end

  function HighlightOverlayGrid:OnCursorMove(cursor_x, cursor_y)
    local center_x, center_y = self.inner_circle:GetCenter();
    local angle = math.atan2(cursor_y - center_y, cursor_x - center_x);
    angle = angle > 0 and angle or radian_from_degree(360) + angle;

    for i, record in ipairs(self.sectors) do
      local sector = record.sector;
      if (sector:Contains(angle)) then
        self.last_active_sector = record.eight_sector;
        self:EnableSector(record.eight_sector);
        break;
      end
    end
  end

  function HighlightOverlayGrid:EnableSector(eight_sector)
    local images = sector_grid_images[eight_sector];
    self.center_far_right:SetTexture(images[HighlightOverlayGridSection.CENTER_FAR_RIGHT]);
    self.center_right:SetTexture(images[HighlightOverlayGridSection.CENTER_RIGHT]);
    self.top_far_right:SetTexture(images[HighlightOverlayGridSection.TOP_FAR_RIGHT]);
    self.top_right:SetTexture(images[HighlightOverlayGridSection.TOP_RIGHT]);
    self.top_far_left:SetTexture(images[HighlightOverlayGridSection.TOP_FAR_LEFT]);
    self.top_left:SetTexture(images[HighlightOverlayGridSection.TOP_LEFT]);
    self.center_far_left:SetTexture(images[HighlightOverlayGridSection.CENTER_FAR_LEFT]);
    self.center_left:SetTexture(images[HighlightOverlayGridSection.CENTER_LEFT]);
    self.bottom_far_left:SetTexture(images[HighlightOverlayGridSection.BOTTOM_FAR_LEFT]);
    self.bottom_left:SetTexture(images[HighlightOverlayGridSection.BOTTOM_LEFT]);
    self.bottom_far_right:SetTexture(images[HighlightOverlayGridSection.BOTTOM_FAR_RIGHT]);
    self.bottom_right:SetTexture(images[HighlightOverlayGridSection.BOTTOM_RIGHT]);
  end

  -- local sector = Sector:New(22.5, 45);

  local full_diameter = pythag(GetScreenWidth(), GetScreenHeight());
  local x_offset = (GetScreenWidth() - full_diameter) / 2;
  local y_offset = (GetScreenHeight() - full_diameter) / 2;

  local inner_diameter = 100;
  local inner_x_offset = (GetScreenWidth() - inner_diameter) / 2;
  local inner_y_offset = (GetScreenHeight() - inner_diameter) / 2;
  local inner_circle = Circle:New(inner_x_offset, inner_y_offset, 100);

  f = CreateFrame("Frame", "OMNIHUD_FRAME", UIParent);
  f:SetFrameStrata("FULLSCREEN");
  f:SetWidth(GetScreenWidth());
  f:SetHeight(GetScreenHeight());
  f:SetPoint("CENTER",0,0);
  f:EnableMouse(true);
  tinsert(UISpecialFrames, "OMNIHUD_FRAME");

  -- AddTestFontsToFrame("CHARACTER", f);

  local t = f:CreateTexture(nil,"BACKGROUND");
  t:SetColorTexture(0.0, 0.0, 0.0, 0.5);
  t:SetAllPoints(f);
  f.texture = t;

  local highlight_overlay_grid = HighlightOverlayGrid:New(f);
  highlight_overlay_grid.frame:SetWidth(GetScreenWidth());
  highlight_overlay_grid.frame:SetHeight(GetScreenHeight());
  highlight_overlay_grid.frame:SetPoint("CENTER",0,0);

  gPreviousX = nil
  gPreviousY = nil
  f:SetScript("OnUpdate", function(self, elapsedSeconds)
    local ui_scale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition()
    local tex = UIParent:CreateTexture()
      if (x ~= gPreviousX or y ~= gPreviousY) then
        highlight_overlay_grid:OnCursorMove(x / ui_scale, y / ui_scale);
      end
  end);

  f:SetScript("OnShow", function()
  end);

  f:SetScript("OnHide", function()
    local last_active_sector = highlight_overlay_grid.last_active_sector;
    if (last_active_sector == EightSector.ONE) then
      ToggleSpellBook(1);
    elseif (last_active_sector == EightSector.FIVE) then
      ToggleCharacter("PaperDollFrame");
    else
    end
  end);

  local function OmniWheel_SlashCommand(msg, editbox)
    if msg == 'show' then
      f:Show();
    elseif msg == 'hide' then
      f:Hide();
    else
      print("UNEXPECTED INPUT");
    end
  end


  SLASH_OMNIHUD1, SLASH_OMNIHUD2 = '/omnih', '/omnihud';
  SlashCmdList["OMNIHUD"] = OmniWheel_SlashCommand;
end

print("Loading OmniWheel...");
local status, err = pcall(main);
if status == false then
  print(status, err);
end

