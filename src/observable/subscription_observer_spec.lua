local SubscriptionObserver = require("observable.subscription_observer");
local Subscription = require("observable.subscription");

describe("observable.subscription_observer", function()
  local handler = function() end
  local subscriber = function() return handler end

  describe("SubscriptionObserver", function()
    describe(":New", function()
      it("takes a Subscription and next, error and complete functions", function()
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        assert.has.error(function()
          SubscriptionObserver:New()
        end, "subscription must be a Subscription")

        assert.has.error(function()
          SubscriptionObserver:New(subscription)
        end, "next_handler must be a function")

        assert.has.error(function()
          SubscriptionObserver:New(subscription, handler)
        end, "error_handler must be a function")

        assert.has.error(function()
          SubscriptionObserver:New(subscription, handler, handler)
        end, "complete_handler must be a function")

        assert.has_no.errors(function()
          SubscriptionObserver:New(subscription, handler, handler, handler)
        end)
      end)
    end)

    describe(":Next", function()
      it("calls the next handler", function()
        local next_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, next_handler, handler, handler)
        assert.is_nil(subsc_obsvr:Next("next-value"))
        assert.spy(next_handler).was_called(1)
        assert.spy(next_handler).was_called_with("next-value")
      end)

      it("does not call the next handler when closed", function()
        local next_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, next_handler, handler, handler)
        subsc_obsvr:Complete()
        subsc_obsvr:Next("next-value")
        assert.spy(next_handler).was_not_called(1)
      end)
    end)

    describe(":Error", function()
      it("calls the error handler", function()
        local error_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, handler, error_handler, handler)
        assert.is_nil(subsc_obsvr:Error("error-value"))
        assert.spy(error_handler).was_called(1)
        assert.spy(error_handler).was_called_with("error-value")
      end)

      it("does not call the error handler when closed", function()
        local error_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, handler, error_handler, handler)
        subsc_obsvr:Complete()
        subsc_obsvr:Error("error-value")
        assert.spy(error_handler).was_not_called()
      end)
    end)

    describe(":Complete", function()
      it("calls the completion handler", function()
        local complete_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, handler, handler, complete_handler)
        assert.is_nil(subsc_obsvr:Complete())
        assert.spy(complete_handler).was_called(1)
      end)

      it("sets the SubscriptionObservable to closed", function()
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, handler, handler, handler)
        assert.is_false(subsc_obsvr:Closed())
        subsc_obsvr:Complete()
        assert.is_true(subsc_obsvr:Closed())
      end)

      it("does not call the completion handler when closed", function()
        local complete_handler = spy.new(function(val) end)
        local subscription = Subscription:New(subscriber, handler, handler, handler)
        local subsc_obsvr = SubscriptionObserver:New(subscription, handler, handler, complete_handler)
        subsc_obsvr:Complete()
        subsc_obsvr:Complete()
        assert.spy(complete_handler).was_called(1)
      end)
    end)

  end)
end)