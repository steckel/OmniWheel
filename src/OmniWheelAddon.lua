module("OmniWheelAddon", package.seeall);

local Subject = require("observable.subject");
local WheelView = require("WheelView");

function bind(func, context)
  return function(...)
    func(context, ...)
  end
end

function printo(obj, i)
  if type(val) ~= 'table' then print(obj); return end
  i = i or 1
  local it = 1
  local indent = ""
  while it <= i do
    indent = indent .. " "
    it = it + 1
  end
  print(indent .. "{")
  for key, val in pairs(obj) do
    if type(val) ~= 'table' then
      print(indent .. indent .. key .. ' = ', val)
    else
      printo(val, i + 1)
    end
  end
  print(indent .. "}")
  if i == 1 then print("\n") end
end

----------------------------------------------------------------------------

local initial_state = { visible = false, active_sector = nil }

function copy(obj)
  if type(obj) ~= 'table' then return obj end
  local res = {}
  for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  return res
end

function assign(target, source)
  for k, v in pairs(source) do target[k] = v end
  return target
end

function reducer(prev_state, action)
  prev_state = copy(prev_state)

  if (action.type == "SHOW_WHEEL") then
    return assign(prev_state, {visible = true})
  elseif (action.type == "HIDE_WHEEL") then
    return assign(prev_state, {visible = false})
  elseif (action.type == "SECTOR_HOVER") then
    return assign(prev_state, {active_sector = action.data})
  end

  return prev_state
end


function observe_changes(observable, selector_fn)
  return observable
    :Map(selector_fn)
    :Reduce(function(prev_vals, next_val) return {prev_vals[2], next_val} end, {nil})
    :Filter(function(tuple) return tuple[1] ~= tuple[-1] end)
    :Map(function(tuple) return tuple[2] end)
end

function on_wheel_close(active_sector)
  if (active_sector == EightSector.ONE) then
    -- MAP
    ToggleFrame(WorldMapFrame);
  elseif (active_sector == EightSector.TWO) then
    -- SPELL BOOK
    ToggleSpellBook(BOOKTYPE_SPELL);
  elseif (active_sector == EightSector.THREE) then
    -- QUEST LOG
    ToggleQuestLog();
  elseif (active_sector == EightSector.FOUR) then
    -- TALENTS
    ToggleTalentFrame();
  elseif (active_sector == EightSector.FIVE) then
    -- CHARACTER
    ToggleCharacter("PaperDollFrame");
  elseif (active_sector == EightSector.SIX) then
    -- SOCIAL
    ToggleFriendsFrame();
  elseif (active_sector == EightSector.SEVEN) then
    -- ALL BAGS
    ToggleAllBags();
  elseif (active_sector == EightSector.EIGHT) then
    -- REQUEST HELP
    ToggleHelpFrame();
  else
    -- shrug
  end
end

----------------------------------------------------------------------------

-- OmniWheelAddon
OmniWheelAddon = {};
OmniWheelAddon.__index = OmniWheelAddon;

function OmniWheelAddon:New(uiparent)
  local self = setmetatable({}, OmniWheelAddon);
  self.actions = Subject:New()
  local state_observable = self.actions:Reduce(reducer, initial_state)

  state_observable
    :Reduce(function(prev_vals, next_val) return {prev_vals[2], next_val} end, {})
    :Filter(function(tuple) return tuple[1]['visible'] ~= tuple[2]['visible'] end)
    :Map(function(tuple) return tuple[2]['active_sector'] end)
    :Subscribe(on_wheel_close)

  self.wheel_view = WheelView:New(uiparent, self.actions, state_observable)

  return self;
end

function OmniWheelAddon:ShowWheel()
  self.actions:Next({type = "SHOW_WHEEL"})
end

function OmniWheelAddon:HideWheel()
  self.actions:Next({type = "HIDE_WHEEL"})
end

return OmniWheelAddon;
