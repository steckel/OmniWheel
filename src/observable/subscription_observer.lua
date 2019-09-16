module("observable.subscription_observer", package.seeall);

local assert_instance_of = function(instance, class, message)
  assert(instance, message);
  assert(class, message);
  local m = getmetatable(instance)
  if (m == nil) then return false end
  assert(m.__index == class, message)
end

local assert_callable = function(callable, message)
  local m = getmetatable(callable);
  if (m == nil) then
    assert(type(callable) == "function", message);
  else
    assert(type(m.__call) == "function", message);
  end
end

local assert_is_subscription_like = function(instance, message)
  assert(instance, message);
  assert_callable(instance.Unsubscribe, message)
  assert_callable(instance.IsClosed, message)
end

SubscriptionObserver = {};
SubscriptionObserver.__index = SubscriptionObserver;

function SubscriptionObserver:New(subscription, next_handler, error_handler, complete_handler)
  local self = setmetatable({}, SubscriptionObserver)
  assert_is_subscription_like(subscription, "subscription must be a Subscription")
  assert_callable(next_handler, "next_handler must be a function")
  assert_callable(error_handler, "error_handler must be a function")
  assert_callable(complete_handler, "complete_handler must be a function")
  self._subscription = subscription
  self._next_handler = next_handler
  self._error_handler = error_handler
  self._complete_handler = complete_handler
  self._closed = false
  return self
end

function SubscriptionObserver:Closed()
  return self._subscription:IsClosed();
end

function SubscriptionObserver:Next(value)
  if self:Closed() then return end
  local success, error_or_value = pcall(self._next_handler, value)
  if not success then error(error_or_value, 2) end
end

function SubscriptionObserver:Error(err)
  if self:Closed() then return end
  self._error_handler(err);
end

function SubscriptionObserver:Complete()
  if self:Closed() then return end
  self._subscription:Unsubscribe()
  local success, error_or_value = pcall(self._complete_handler, value)
  if not success then error(error_or_value, 2) end
end

return SubscriptionObserver;
