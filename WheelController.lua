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
  print('WheelController:OnWheelSectorHover('..sector..')');
  self.active_sector = sector;
end

function WheelController:OnWheelShow()
  print('WheelController:OnWheelShow()');
  self.active_sector = nil;
end

function WheelController:OnWheelHide()
  if self.active_sector == nil then
    return;
  end

  if (self.active_sector == EightSector.ONE) then
    ToggleSpellBook(1);
  elseif (self.active_sector == EightSector.FIVE) then
    ToggleCharacter("PaperDollFrame");
  else
    -- shrug
  end
  -- local action = self.configuration:GetActionForSector(self.active_sector);
  -- action.fn();
end
