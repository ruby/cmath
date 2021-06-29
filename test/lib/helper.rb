require "test/unit"
require_relative "core_assertions"

Test::Unit::TestCase.include Test::Unit::CoreAssertions

module Test
  module Unit
    class TestCase
      def assert_in_delta exp, act, delta = 0.001, msg = nil
        n = (exp - act).abs
        msg = message(msg) {
          "Expected |#{exp} - #{act}| (#{n}) to be <= #{delta}"
        }
        assert delta >= n, msg
      end
    end
  end
end
