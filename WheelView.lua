---
-- WheelView is similar to a View in the MVC architecture.
-- WheelView is the interface for the application to express wheel state.
WheelView = {}
WheelView.__index = WheelView;

function WheelView:New(uiparent)
  local self = setmetatable({}, WheelView);

  self.frame = CreateFrame("Frame", nil, uiparent);
  self.frame:Hide();
  self.frame:SetFrameStrata("FULLSCREEN");
  -- NOTE(steckel): Do we need ui_scale here?
  --local ui_scale = parent_frame:GetEffectiveScale();
  --self.frame:SetScale(1 / ui_scale);
  -- FIXME(steckel): Inject GetScreenWidth and GetScreenHeight values
  self.frame:SetWidth(GetScreenWidth());
  self.frame:SetHeight(GetScreenHeight());
  self.frame:SetPoint("CENTER",0,0);
  -- self.frame:EnableMouse(true);
  -- Sectors
  -- FIXME(steckel): Just make the EightSector the key
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
  -- Mouse Tracking
  self.previous_x = 0;
  self.previous_y = 0;
  -- Texture Rendering
  self.renderer = WheelViewRenderer:New(self.frame);
  -- Event Handling
  self.callbacks = {
    ON_SHOW = {},
    ON_HIDE = {},
    ON_SECTOR_HOVER = {},
  };
  return self;
end

function WheelView:OnCursorMove(cursor_x, cursor_y)
  local center_x, center_y = self.frame:GetCenter();
  local angle = math.atan2(cursor_y - center_y, cursor_x - center_x);
  angle = angle > 0 and angle or radian_from_degree(360) + angle;

  for key, value in pairs(self.sectors) do
    local sector = value.sector;
    local eight_sector = value.eight_sector;
    if (sector:Contains(angle)) then
      self.renderer:ShowWheelSectorHighlight(eight_sector);
      self:Trigger("ON_SECTOR_HOVER", eight_sector);
      break;
    end
  end
end

function WheelView:Trigger(event, value)
  if not (event == "ON_SHOW" or event == "ON_HIDE" or event == "ON_SECTOR_HOVER") then
    return;
  end

  for i, callback in pairs(self.callbacks[event]) do
    local status, err = pcall(callback.fn, callback.caller, value);
    if status == false then
      print(status, err);
    end
  end
end

function WheelView:AddEventListener(event, fn, caller)
  if not (event == "ON_SHOW" or event == "ON_HIDE" or event == "ON_SECTOR_HOVER") then
    return;
  end

  table.insert(self.callbacks[event], {fn = fn, caller = caller});
end

function WheelView:RemoveEventListener(event, callback)
end

function WheelView:Show()
  self.frame:Show();
  -- FIXME(steckel): Why can't this just be SetScript("OnUpdate", self.OnUpdate);
  local this = self;
  self.frame:SetScript("OnUpdate", function(self, elapsed_seconds)
    local ui_scale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition();
    if (x ~= self.previous_x or y ~= self.previous_y) then
      this:OnCursorMove(x / ui_scale, y / ui_scale);
    end
  end);
  self:Trigger("ON_SHOW");
  -- FIXME(steckel): Code breaks being ran after that above loop.
end

function WheelView:Hide()
  self.frame:Hide();
  self.frame:SetScript("OnUpdate", nil);
  self:Trigger("ON_HIDE");
end
