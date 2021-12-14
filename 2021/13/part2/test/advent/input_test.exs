defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      assert TestHelpers.parsed_example() == [
        [
          {6, 10},
          {0, 14},
          {9, 10},
          {0, 3},
          {10, 4},
          {4, 11},
          {6, 0},
          {6, 12},
          {4, 1},
          {0, 13},
          {10, 12},
          {3, 4},
          {3, 0},
          {8, 4},
          {1, 10},
          {2, 14},
          {8, 10},
          {9, 0}
        ],
        {:y, 7},
        {:x, 5}
      ]
    end
  end
end
