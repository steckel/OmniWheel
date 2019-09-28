module("observable", package.seeall);

local Subscription = require("observable.subscription");

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

--[[
-- # Observable is an object you can subscribe to.
--
-- # An observer is an object/function(s) that subscribes to events (next,
-- error, complete).
--
-- # A subscription observer is a proxy for the observer (passed into the
-- subscriber).
--
-- # A subscriber is a function that creates events (by wiring up subscription
-- oobserver's next, error, complete)
--
-- # A subscription is the result of of an observer (that lets you unsubscribe).
--]]
Observable = {};
Observable.__index = Observable;

function Observable:New(subscriber)
  local self = setmetatable({}, Observable);
  assert_callable(subscriber, "subscriber must be a function")
  self._subscriber = subscriber;
  return self;
end

function Observable:Subscribe(next_handler, error_handler, complete_handler)
  if type(next_handler) == "table" and is_callable(next_handler.Next) then
    error_handler = next_handler.Error ~= nil and next_handler.Error or function() end
    complete_handler = next_handler.Complete ~= nil and next_handler.Complete or function() end
    next_handler = next_handler.Next
  end

  error_handler = error_handler ~= nil and error_handler or function() end
  complete_handler = complete_handler ~= nil and complete_handler or function() end

  assert_callable(next_handler, "next_handler must be a function");
  assert_callable(error_handler, "error_handler must be a function");
  assert_callable(complete_handler, "complete_handler must be a function");

  return Subscription:New(self._subscriber, next_handler, error_handler, complete_handler)
end

function Observable:Map(mapper)
  return Observable:New(function(observer)
    local next_handler = function(val) observer:Next(mapper(val)) end
    return self:Subscribe(next_handler, observer.Error, observer.Complete).Unsubscribe
  end)
end

function Observable:Filter(predicate)
  return Observable:New(function(observer)
    local next_handler = function(val)
      if predicate(val) then observer:Next(val) end
    end
    return self:Subscribe(next_handler, observer.Error, observer.Complete).Unsubscribe
  end)
end

function Observable:Reduce(reducer, initial)
  local index = 1
  local current = initial
  return Observable:New(function(observer)
    local next_handler = function(val)
      current = reducer(current, val, index)
      observer:Next(current)
      index = index + 1
    end
    return self:Subscribe(next_handler, observer.Error, observer.Complete).Unsubscribe
  end)
end

function Observable:IsClosed()
end

return Observable;
