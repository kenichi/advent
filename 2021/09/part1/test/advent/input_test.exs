defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      {map, mx, my} = TestHelpers.parsed_example()

      assert mx == 9
      assert my == 4

      # just spot check a few
      assert map[{0, 0}] == 2
      assert map[{mx, 0}] == 0
      assert map[{0, my}] == 9
      assert map[{mx, my}] == 8
    end
  end
end
