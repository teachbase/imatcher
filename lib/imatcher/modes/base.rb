module Imatcher
  module Modes
    class Base
      include ColorMethods

      attr_reader :result

      def initialize(expected, test, result)
        @expected = expected
        @test = test
        @result = result
      end

      def compare
        @test.compare_each_pixel(@expected) do |test_pixel, expected_pixel, x, y|
          next if pixels_equal?(test_pixel, expected_pixel)
          update_result(test_pixel, expected_pixel, x, y)
        end

        @result.score = score
        @result
      end
    end
  end
end
