export("WheelController", function()
---
-- WheelController is similar to a Controller in the MVC architecture.
WheelController = {}
WheelController.__index = WheelController;

function WheelController:New(configuration)
  local self = setmetatable({}, WheelController);
  self.configuration = configuration;
  self.active_sector = nil;
  return self;
end

function WheelController:OnWheelSectorHover(sector)
  self.active_sector = sector;
end

function WheelController:OnWheelShow()
  self.active_sector = nil;
end

function WheelController:OnWheelHide()
  if self.active_sector == nil then
    return;
  end

  if (self.active_sector == EightSector.ONE) then
    -- MAP
    ToggleFrame(WorldMapFrame);
  elseif (self.active_sector == EightSector.TWO) then
    -- SPELL BOOK
    ToggleSpellBook(1);
  elseif (self.active_sector == EightSector.THREE) then
    -- QUEST LOG
    ToggleQuestLog();
  elseif (self.active_sector == EightSector.FOUR) then
    -- TALENTS
    ToggleTalentFrame();
  elseif (self.active_sector == EightSector.FIVE) then
    -- CHARACTER
    ToggleCharacter("PaperDollFrame");
  elseif (self.active_sector == EightSector.SIX) then
    -- SOCIAL
    ToggleFriendsFrame();
  elseif (self.active_sector == EightSector.SEVEN) then
    -- ALL BAGS
    ToggleAllBags();
  elseif (self.active_sector == EightSector.EIGHT) then
    -- REQUEST HELP
    ToggleHelpFrame();
  else
    -- shrug
  end
  -- local action = self.configuration:GetActionForSector(self.active_sector);
  -- action.fn();
end

return WheelController;

end);
