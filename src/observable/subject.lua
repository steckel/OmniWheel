module("observable.subject", package.seeall);

local Observable = require("observable.observable");
local Set = require("set");

local is_callable = function(callable)
  local m = getmetatable(callable);
  if (m == nil) then
    return type(callable) == "function"
  else
    return type(m.__call) == "function"
  end
end

local assert_callable = function(callable, message)
  local m = getmetatable(callable);
  if (m == nil) then
    assert(type(callable) == "function", message);
  else
    assert(type(m.__call) == "function", message);
  end
end

function bind(func, context)
  return function(...)
    func(context, ...)
  end
end

Subject = {};
Subject.__index = Subject;
setmetatable(Subject, Observable);

function Subject:New()
  local self = setmetatable({}, Subject);
  self._on_next_handlers = Set:New()
  self._on_error_handlers = Set:New()
  self._on_complete_handlers = Set:New()
  self._subscriber = function(observer)
    local on_next_handler = function(val) observer:Next(val) end
    local on_error_handler = function(e) observer:Error(e) end
    local on_complete_handler = function() observer:Complete() end
    self._on_next_handlers:Insert(on_next_handler)
    self._on_error_handlers:Insert(on_error_handler)
    self._on_complete_handlers:Insert(on_complete_handler)
    return function()
      self._on_next_handlers:Remove(on_next_handler)
      self._on_error_handlers:Remove(on_error_handler)
      self._on_complete_handlers:Remove(on_complete_handler)
    end
  end
  return self;
end

function Subject:Observe()
  return Observable:New(function(observer)
    return bind(self:Subscribe(
      bind(observer.Next, observer),
      bind(observer.Error, observer),
      bind(observer.Complete, observer)
    ).Unsubscribe, self)
  end)
end

function Subject:Next(val)
  for handler in self._on_next_handlers:Values() do
    handler(val)
  end
end

function Subject:Error(e)
  for handler in self._on_error_handlers:Values() do
    handler(e)
  end
end

function Subject:Complete()
  for handler in self._on_complete_handlers:Values() do
    handler()
  end
end

return Subject;
