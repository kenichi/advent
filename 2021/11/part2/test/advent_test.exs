defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 195
    end
  end

  describe "Advent.surroundings/1" do
    test "middle {5,5}" do
      assert Advent.surroundings({5,5}) == [
        {6, 5},
        {6, 6},
        {5, 6},
        {4, 6},
        {4, 5},
        {4, 4},
        {5, 4},
        {6, 4}
      ]
    end
    
    test "corner {0,0}" do
      assert Advent.surroundings({0,0}) == [
        {1, 0},
        {1, 1},
        {0, 1}
      ]
    end

    test "edge {0,5}" do
      assert Advent.surroundings({0,5}) == [
        {1, 5},
        {1, 6},
        {0, 6},
        {0, 4},
        {1, 4}
      ]
    end
  end
end
