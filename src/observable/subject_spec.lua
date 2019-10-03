local Subject = require("observable.subject");

describe("observable.subject", function()

  describe("Subject", function()

    describe(":New", function()
      it("doesn't explode", function()
        assert.has_no.errors(function()
          Subject:New()
        end)
      end)
    end)

    describe("\"Observability\"", function()
      pending("behaves like an instance an Observable instance", function()
      end)
    end)

    describe(":Observe", function()
      pending("returns an Observable based on the Subject", function()
      end)
    end)

    describe(":Next", function()
      it("triggers the subscribers' next handler", function()
        local subject = Subject:New()
        local next_handler_a = spy.new(function() end)
        local subscriber_a = subject:Subscribe(next_handler_a)
        local next_handler_b = spy.new(function() end)
        local subscriber_b = subject:Subscribe(next_handler_b)

        subject:Next(1)
        subject:Next(2)
        subject:Next(3)

        assert.spy(next_handler_a).called(3)
        assert.spy(next_handler_a).called_with(1)
        assert.spy(next_handler_a).called_with(2)
        assert.spy(next_handler_a).called_with(3)
        assert.spy(next_handler_b).called(3)
        assert.spy(next_handler_b).called_with(1)
        assert.spy(next_handler_b).called_with(2)
        assert.spy(next_handler_b).called_with(3)
      end)
    end)

    describe(":Error", function()
      it("triggers the subscribers' error handler", function()
        local subject = Subject:New()
        local error_handler_a = spy.new(function() end)
        local subscriber_a = subject:Subscribe(function()end,error_handler_a)
        local error_handler_b = spy.new(function() end)
        local subscriber_b = subject:Subscribe(function()end,error_handler_b)

        subject:Error("NOT_FOUND")
        subject:Error("INTERNAL_ERROR")

        assert.spy(error_handler_a).called(2)
        assert.spy(error_handler_a).called_with("NOT_FOUND")
        assert.spy(error_handler_a).called_with("INTERNAL_ERROR")
        assert.spy(error_handler_b).called(2)
        assert.spy(error_handler_b).called_with("NOT_FOUND")
        assert.spy(error_handler_b).called_with("INTERNAL_ERROR")
      end)
    end)

    describe(":Complete", function()
      it("triggers the subscribers' complete handler", function()
        local handler = function() end
        local subject = Subject:New()
        local complete_handler_a = spy.new(function() end)
        local subscriber_a = subject:Subscribe(handler, handler, complete_handler_a)
        local complete_handler_b = spy.new(function() end)
        local subscriber_b = subject:Subscribe(handler, handler, complete_handler_b)

        subject:Complete()
        subject:Complete()

        assert.spy(complete_handler_a).called(1)
        assert.spy(complete_handler_b).called(1)
      end)
    end)

  end)

end)
