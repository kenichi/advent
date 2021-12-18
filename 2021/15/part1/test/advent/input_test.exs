defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      # {map, mx, my} = TestHelpers.parsed_example()
      map = TestHelpers.parsed_example()

      # assert mx == 9
      # assert my == 9

      assert map[{0, 0}] == 1
      assert map[{5, 0}] == 5
      assert map[{9, 0}] == 2
      assert map[{9, 5}] == 7
      assert map[{9, 9}] == 1
      assert map[{5, 9}] == 4
      assert map[{0, 9}] == 2
      assert map[{0, 5}] == 1
    end
  end
end
