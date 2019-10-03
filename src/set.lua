module("set", package.seeall);

Set = {}
Set.__index = Set

function Set:New()
  local self = setmetatable({}, Set);
  self._count = 0
  self._n = 0
  self._index_to_value = {}
  self._value_to_index = {}
  return self;
end

function Set:Count()
  return self._n
end

function Set:Insert(val)
  if (self:Contains(val)) then
    return
  end
  self._count = self._count + 1
  self._n = self._n + 1
  self._index_to_value[self._count] = val
  self._value_to_index[val] = self._count
end

function Set:Remove(val)
  if (not self:Contains(val)) then
    return
  end
  local i = self._value_to_index[val]
  self._index_to_value[i] = nil
  self._value_to_index[val] = nil
  self._n = self._n - 1
end

function Set:Contains(val)
  return self._value_to_index[val] ~= nil
end

function Set:Values()
  local i = 1
  local n = self._count
  return function()
    while i <= n do
      local val = self._index_to_value[i]
      i = i + 1
      if val ~= nil then
        return val
      end
    end
    return nil
  end
end

return Set;
