defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      map = TestHelpers.parsed_example()

      # just spot check a few
      assert map[{0, 0}] == 2
      assert map[{9, 0}] == 0
      assert map[{0, 4}] == 9
      assert map[{9, 4}] == 8
    end
  end
end
