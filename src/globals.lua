function pythag(a, b)
  return math.sqrt((a ^ 2) + (b ^ 2));
end

function slope(x1, y1, x2, y2)
  return (y2 - y1) / (x2 - x1);
end

function radian_from_degree(angle)
  return angle * math.pi / 180;
end

function degrees_from_radians(radians)
  return radians * (180/math.pi);
end

function polar_to_cartesian(theta, radius)
  local x = radius * math.cos(theta);
  local y = radius * math.sin(theta);
  return x,y;
end

kTexturesDirectory = "Interface\\AddOns\\OmniWheel\\textures\\";

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

EightSector = {
  ONE = 1,
  TWO = 2,
  THREE = 3,
  FOUR = 4,
  FIVE = 5,
  SIX = 6,
  SEVEN = 7,
  EIGHT = 8
};

HighlightOverlayGridSection = {
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
sector_grid_images = {
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
