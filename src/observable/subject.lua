module("observable.subject", package.seeall);

local Observable = require("observable.observable");

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
  self._on_next_handlers = {}
  self._on_error_handlers = {}
  self._on_complete_handlers = {}
  self._subscriber = function(observer)
    self:_OnNext(function(val) observer:Next(val) end)
    self:_OnError(function(e) observer:Error(e) end)
    self:_OnComplete(function() observer:Complete() end)
    return function()
      self:_UnSubscribe()
    end
  end
  return self;
end

function Subject:Observe()
  return Observable:New(function(observer)
    return self:Subscribe(
      bind(observer.Next, observer),
      bind(observer.Error, observer),
      bind(observer.Complete, observer)
    ).Unsubscribe
  end)
end

function Subject:Next(val)
  for _, handler in pairs(self._on_next_handlers) do
    handler(val)
  end
end

function Subject:Error(e)
  for _, handler in pairs(self._on_error_handlers) do
    handler(e)
  end
end

function Subject:Complete(val)
  for _, handler in pairs(self._on_complete_handlers) do
    handler()
  end
end

function Subject:_OnNext(handler)
  table.insert(self._on_next_handlers, handler)
end

function Subject:_OnError(handler)
  table.insert(self._on_error_handlers, handler)
end

function Subject:_OnComplete(handler)
  table.insert(self._on_complete_handlers, handler)
end



return Subject;
