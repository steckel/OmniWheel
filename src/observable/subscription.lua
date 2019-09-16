module("observable.subscription", package.seeall);

local SubscriptionObserver = require("observable.subscription_observer");

local is_callable = function(callable)
  local m = getmetatable(callable)
  if (m ~= nil) then
    callable = m.__call
  end
  return type(callable) == "function"
end

local assert_callable = function(callable, message)
  assert(callable, message);
  local m = getmetatable(callable);
  if (m == nil) then
    assert(type(callable) == "function", message);
  else
    assert(type(m.__call) == "function", message);
  end
end

Subscription = {};
Subscription.__index = Subscription;

function Subscription:New(subscriber, next_handler, error_handler, complete_handler)
  local self = setmetatable({}, Subscription)
  assert_callable(subscriber, "subscriber must be a function")
  assert_callable(next_handler, "next_handler must be a function");
  assert_callable(error_handler, "error_handler must be a function");
  assert_callable(complete_handler, "complete_handler must be a function");

  self._closed = false

  local subscription_observer = SubscriptionObserver:New(
      self, next_handler, error_handler, complete_handler)
  local success, error_or_cleanup = pcall(subscriber, subscription_observer)
  if not success then
    subscription_observer:Error(error_or_cleanup)
  elseif not is_callable(error_or_cleanup) then
    subscription_observer:Error("Subscriber must return a function")
  end

  self._cleanup = error_or_cleanup

  return self
end

function Subscription:Unsubscribe()
  self._closed = true
  self._cleanup()
  self._cleanup = nil
end

function Subscription:IsClosed()
  return self._closed
end

return Subscription;
