defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      observed = TestHelpers.parsed_example()

      expected = [
        {
          ['acedgfb', 'cdfbe', 'gcdfa', 'fbcad', 'dab', 'cefabd', 'cdfgeb', 'eafb', 'cagedb', 'ab'],
          ['cdfeb', 'fcadb', 'cdfeb', 'cdbaf']
        }
      ]

      assert observed == expected
    end
  end
end
