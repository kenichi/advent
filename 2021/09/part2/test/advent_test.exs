defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 1134
    end
  end

  describe "Advent.basin_size/2" do
    setup [:parse_example]

    test "example input top left", %{example: ex} do
      assert Advent.basin_size({1,0}, ex) == 3
    end

    test "example input top right", %{example: ex} do
      assert Advent.basin_size({9,0}, ex) == 9
    end

    test "example input middle", %{example: ex} do
      assert Advent.basin_size({2,2}, ex) == 14
    end

    test "example input bottom right", %{example: ex} do
      assert Advent.basin_size({6,4}, ex) == 9
    end
  end

  describe "Advent.lowest_points/1" do
    setup [:parse_example]

    test "finds and returns lowest points", %{example: ex} do
      assert Advent.lowest_points(ex) == [{9,0}, {6,4}, {1,0}, {2,2}]
    end
  end
end
