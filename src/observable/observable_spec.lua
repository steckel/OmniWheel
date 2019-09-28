local Observable = require("observable.observable");

local function is_observer(state, arguments)
  return function(value)
    return type(value.Next) == "function" and
        type(value.Error) == "function" and
        type(value.Complete) == "function"
  end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

assert:register("matcher", "observer", is_observer)

describe("observable.observable", function()
  local handler = function() end

  describe("Observable", function()
    describe(":New", function()
      it("takes a subscriber function", function()
        assert.has.error(function()
          Observable:New()
        end, "subscriber must be a function")

        assert.has_no.errors(function()
          Observable:New(handler)
        end)
      end)
    end)

    describe(":Subscribe", function()
      local observable = Observable:New(handler)

      it("requires a next_handler function", function()
        assert.has.error(function()
          observable:Subscribe()
        end, "next_handler must be a function")

        assert.has_no.errors(function()
          observable:Subscribe(handler)
        end)
      end)

      it("accepts an error_handler and complete_handler function", function()
        assert.has.error(function()
          observable:Subscribe(handler, true)
        end, "error_handler must be a function")

        assert.has.error(function()
          observable:Subscribe(handler, handler, true)
        end, "complete_handler must be a function")

        assert.has_no.errors(function()
          observable:Subscribe(handler, handler, handler)
        end)
      end)

      it("accepts a table of functions", function()
        assert.has.error(function()
          observable:Subscribe({})
        end, "next_handler must be a function")

        assert.has.error(function()
          observable:Subscribe({Next = handler, Error = true})
        end, "error_handler must be a function")

        assert.has.error(function()
          observable:Subscribe({Next = handler, Error = handler, Complete = true})
        end, "complete_handler must be a function")

        assert.has_no.errors(function()
          observable:Subscribe({Next = handler})
        end)

        assert.has_no.errors(function()
          observable:Subscribe({Next = handler, Error = handler, Complete = handler})
        end)
      end)

      it("subscribes via the constructor's subscriber", function()
        local subscriber = spy.new(function() return (function() end) end)
        local observable = Observable:New(subscriber)
        local subscription = observable:Subscribe(function() end)
        assert.spy(subscriber).was_called(1)
        assert.spy(subscriber).was_called_with(match.is_observer())
      end)

      it("returns an open Subscription", function()
        local subscription = observable:Subscribe(handler);
        assert.is.Function(subscription.Unsubscribe)
        assert.is.False(subscription:IsClosed())
      end)

      it("immediately calls the next handler for synchronous values", function()
        local observable = Observable:New(function(observer)
          observer:Next(1);
          observer:Next(2);
          observer:Next(3);
        end)

        local next_handler = spy.new(function() end)
        observable:Subscribe(next_handler)
        assert.spy(next_handler).called(3)
        assert.spy(next_handler).was_called_with(1)
        assert.spy(next_handler).was_called_with(2)
        assert.spy(next_handler).was_called_with(3)
      end)

      pending("returns a closed Subscription when Observable is closed", function() end)
    end)

    describe("Map", function()
      it("creates a new observer with the result of calling the passed "..
          "mapping function on each value", function()
        local observable = Observable:New(function(observer)
          observer:Next(1);
          observer:Next(2);
          observer:Next(3);
        end)

        local next_handler = spy.new(function() end)
        observable:Subscribe(next_handler)
        assert.spy(next_handler).called(3)
        assert.spy(next_handler).was_called_with(1)
        assert.spy(next_handler).was_called_with(2)
        assert.spy(next_handler).was_called_with(3)

        local mapped_observable = observable:Map(function(val)
          return val + 1
        end)

        local mapped_next_handler = spy.new(function() end)
        mapped_observable:Subscribe(mapped_next_handler)
        assert.spy(mapped_next_handler).called(3)
        assert.spy(mapped_next_handler).was_called_with(2)
        assert.spy(mapped_next_handler).was_called_with(3)
        assert.spy(mapped_next_handler).was_called_with(4)
      end)

      pending("returns a closed Observable when Observable is closed", function() end)
    end)

    describe("Filter", function()
      it("creates a new observer with the filtered reuslts of the passed "..
          "predicate function", function()
        local observable = Observable:New(function(observer)
          observer:Next(1);
          observer:Next(2);
          observer:Next(3);
        end)

        local next_handler = spy.new(function() end)
        observable:Subscribe(next_handler)
        assert.spy(next_handler).called(3)
        assert.spy(next_handler).was_called_with(1)
        assert.spy(next_handler).was_called_with(2)
        assert.spy(next_handler).was_called_with(3)

        local even_numbers = observable:Filter(function(val)
          return val % 2 == 0
        end)

        local filtered_next_handler = spy.new(function() end)
        even_numbers:Subscribe(filtered_next_handler)
        assert.spy(filtered_next_handler).called(1)
        assert.spy(filtered_next_handler).was_called_with(2)
      end)

      pending("returns a closed Observable when Observable is closed", function() end)
    end)

    describe("Reduce", function()
      it("creates a new observer with the result of calling the passed "..
          "reducing function on each value", function()
        local observable = Observable:New(function(observer)
          observer:Next(1);
          observer:Next(2);
          observer:Next(3);
        end)

        local next_handler = spy.new(function() end)
        observable:Subscribe(next_handler)
        assert.spy(next_handler).called(3)
        assert.spy(next_handler).was_called_with(1)
        assert.spy(next_handler).was_called_with(2)
        assert.spy(next_handler).was_called_with(3)

        local reducer = spy.new(function(prev_val, next_val)
          return prev_val + next_val
        end)
        local reduced_observable = observable:Reduce(reducer, 0)
        local reduced_next_handler = spy.new(function() end)
        reduced_observable:Subscribe(reduced_next_handler)

        assert.spy(reducer).called(3)
        assert.spy(reducer).was_called_with(0, 1, 1)
        assert.spy(reducer).was_called_with(1, 2, 2)
        assert.spy(reducer).was_called_with(3, 3, 3)

        assert.spy(reduced_next_handler).called(3)
        assert.spy(reduced_next_handler).was_called_with(1)
        assert.spy(reduced_next_handler).was_called_with(3)
        assert.spy(reduced_next_handler).was_called_with(6)
      end)

      pending("returns a closed Observable when Observable is closed", function() end)
    end)

    pending(":IsClosed", function() end)
  end)
end)
