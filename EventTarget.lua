export("EventTarget", function()

-- TODO(steckel): move to utils
function table_contains(table, value)
  for key, val in pairs(table) do
    if val == value then
      return true;
    end
  end
  return false;
end

function table_keys(tab)
  local keys = {};
  for key, val in pairs(tab) do
    table.insert(keys, key);
  end
  return keys;
end

EventTarget = {};
EventTarget.__index = EventTarget;

function EventTarget:New(event_names)
  local self = setmetatable({}, EventTarget);
  self.event_names = event_names;
  self.callbacks = {};
  for key, value in pairs(event_names) do
    self.callbacks[value] = {};
  end
  return self;
end

function EventTarget:AddEventListener(event, fn, caller)
  if not table_contains(self.event_names, event) then
    print("EventTarget instance does not handle "..event.." events.");
    error("EventTarget instance does not handle "..event.." events.");
  end

  table.insert(self.callbacks[event], {fn = fn, caller = caller});
end

function EventTarget:RemoveEventListener(event, callback)
  print("Hey why don't you implement this?");
  error("lol");
end

function EventTarget:Trigger(event, value)
  if not table_contains(self.event_names, event) then
    print("EventTarget instance does not handle "..event.." events.");
    error("EventTarget instance does not handle "..event.." events.");
  end

  for i, callback in pairs(self.callbacks[event]) do
    -- FIXME(steckel): Remove the injected self assumption.
    local status, err = pcall(callback.fn, callback.caller, value);
    if status == false then
      print(status, err);
    end
  end
end

return EventTarget;

end);
