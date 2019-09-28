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
      pending("triggers the subscribers' error handler", function()
      end)
    end)

    describe(":Complete", function()
      pending("triggers the subscribers' complete handler", function()
      end)
    end)

  end)

end)
