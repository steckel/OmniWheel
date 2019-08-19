print("Loading OmniWheel...");

function main()
  local sector = Sector:New(22.5, 45);

  local full_diameter = pythag(GetScreenWidth(), GetScreenHeight());
  local x_offset = (GetScreenWidth() - full_diameter) / 2;
  local y_offset = (GetScreenHeight() - full_diameter) / 2;

  local inner_diameter = 100;
  local inner_x_offset = (GetScreenWidth() - inner_diameter) / 2;
  local inner_y_offset = (GetScreenHeight() - inner_diameter) / 2;
  local inner_circle = Circle:New(inner_x_offset, inner_y_offset, 100);

  local f = CreateFrame("Frame", "OMNIHUD_FRAME", UIParent);
  f:SetFrameStrata("FULLSCREEN");
  f:SetWidth(GetScreenWidth());
  f:SetHeight(GetScreenHeight());
  f:SetPoint("CENTER",0,0);
  f:EnableMouse(true);
  tinsert(UISpecialFrames, "OMNIHUD_FRAME");

  local t = f:CreateTexture(nil,"BACKGROUND");
  t:SetColorTexture(0.0, 0.0, 0.0, 0.5);
  t:SetAllPoints(f);
  f.texture = t;

  local f2 = CreateFrame("Frame", nil, f);
  f2:SetFrameStrata("FULLSCREEN_DIALOG");
  f2:SetWidth(512);
  f2:SetHeight(512);
  f2:SetPoint("CENTER",0,0);
  local t2 = f2:CreateTexture(nil,"ARTWORK");
  t2:SetTexture("Interface\\AddOns\\OmniWheel\\texture.tga");
  t2:SetAllPoints(f2);
  f2.texture = t2;

  local f3 = CreateFrame("Frame", nil, UIParent);
  f3:SetFrameStrata("FULLSCREEN");
  f3:SetWidth(512);
  f3:SetHeight(512);
  f3:SetPoint("CENTER",0,0);
  local t3 = f3:CreateTexture(nil,"OVERLAY");
  t3:SetTexture("Interface\\AddOns\\OmniWheel\\highlight.tga");
  t3:SetAllPoints(f3);
  f3.texture = t3;

  gPreviousX = nil
  gPreviousY = nil

  f:SetScript("OnUpdate", function(self, elapsedSeconds)
      local cursor_x, cursor_y = GetCursorPosition();
      if (cursor_x ~= gPreviousX or cursor_y ~= gPreviousY) then
        gPreviousX = cursor_x
        gPreviousY = cursor_y
        local center_x, center_y = inner_circle:GetCenter()
        local slope = slope(center_x, center_y, cursor_x, cursor_y);
        local polarcoordinate = math.sqrt(cursor_x^2+cursor_y^2);
        local angle = math.atan2(cursor_y - center_y, cursor_x - center_x);
        local start_angle = radian_from_degree(sector.start_angle);
        local end_angle = radian_from_degree(sector.start_angle + sector.central_angle);
        if (angle>=start_angle and angle < end_angle) then
          f3:Show();
        else
          f3:Hide();
        end
      end
  end);

  f:SetScript("OnShow", function()
    print("OnShow");
  end);

  f:SetScript("OnHide", function()
    print("OnHide");
  end);

  local function OmniWheel_SlashCommand(msg, editbox)
    if msg == 'show' then
      f:Show();
      f2:Show();
    elseif msg == 'hide' then
      f:Hide();
      f2:Hide();
    else
      print("UNEXPECTED INPUT");
    end
  end


  SLASH_OMNIHUD1, SLASH_OMNIHUD2 = '/omnih', '/omnihud';
  SlashCmdList["OMNIHUD"] = OmniWheel_SlashCommand;
  print("Loading OmniWheel complete.");
end
local status, err = pcall(main)
print(status, err)
