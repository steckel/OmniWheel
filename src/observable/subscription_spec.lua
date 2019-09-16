local Subscription = require("observable.subscription");

local function is_observer(state, arguments)
  return function(value)
    return type(value.Next) == "function" and
        type(value.Error) == "function" and
        type(value.Complete) == "function"
  end
end

assert:register("matcher", "observer", is_observer)

describe("observable.subscription", function()
  local handler = function() end
  local subscriber = function() return (function() end) end

  describe("Subscription", function()
    describe(":New", function()
      it("takes a SubscriptionObserver and a function returning function", function()
        assert.has.error(function()
          Subscription:New()
        end, "subscriber must be a function")

        assert.has.error(function()
          Subscription:New(subscriber)
        end, "next_handler must be a function")

        assert.has.error(function()
          Subscription:New(subscriber, handler)
        end, "error_handler must be a function")

        assert.has.error(function()
          Subscription:New(subscriber, handler, handler)
        end, "complete_handler must be a function")

        assert.has_no.errors(function() Subscription:New(subscriber, handler, handler, handler) end) end)

      it("calls SubscriptionObserver:Error when the subscriber does not return a function", function()
        local error_handler = spy.new(function() return (function() end) end)
        local subscription = Subscription:New(handler, handler, error_handler, handler)
        assert.spy(error_handler).was_called(1)
        assert.spy(error_handler).was_called_with(match.matches("Subscriber must return a function"))
      end)

      it("calls SubscriptionObserver:Error when the subscriber throws", function()
        local error_handler = spy.new(function() return (function() end) end)
        local subscriber = function() error("Not good.") end
        local subscription = Subscription:New(subscriber, handler, error_handler, handler)
        assert.spy(error_handler).was_called(1)
        assert.spy(error_handler).was_called_with(match.matches("Not good."))
      end)

      it("returns a Subscription in the open state", function()
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        assert.is_false(subscription:IsClosed())
      end)

      it("calls the subscriber function with the SubscriptionObserver", function()
        local subscriper_spy = spy.new(function() return (function() end) end)
        local subscription = Subscription:New(subscriper_spy, handler, handler, handler)
        assert.spy(subscriper_spy).was_called(1)
        assert.spy(subscriper_spy).was_called_with(match.is_observer())
      end)
    end)

    describe(":Unsubscribe", function()
      local cleanup
      local subscriber
      local subscription

      before_each(function()
        cleanup = spy.new(function() end)
        subscriber = function() return cleanup end
        subscription = Subscription:New(subscriber, handler, handler, handler)
      end)

      it("cleans up", function()
        subscription:Unsubscribe()
        assert.spy(cleanup).was_called(1)
      end);

      it("sets to close", function()
        assert.is_false(subscription:IsClosed())
        subscription:Unsubscribe()
        assert.is_true(subscription:IsClosed())
      end);
    end)

  end)
end)
