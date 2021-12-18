defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 315
    end
  end

  describe "Advent.multiply_map/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      mm = Advent.multiply_map(ex)

      assert mm[{0, 0}] == 1
      assert mm[{5, 0}] == 5
      assert mm[{9, 0}] == 2
      assert mm[{9, 5}] == 7
      assert mm[{9, 9}] == 1
      assert mm[{5, 9}] == 4
      assert mm[{0, 9}] == 2
      assert mm[{0, 5}] == 1

      assert mm[{10, 0}] == 2
      assert mm[{15, 0}] == 6
      assert mm[{19, 0}] == 3
      assert mm[{19, 5}] == 8
      assert mm[{19, 9}] == 2
      assert mm[{15, 9}] == 5
      assert mm[{10, 9}] == 3
      assert mm[{10, 5}] == 2

      assert mm[{10, 20}] == 4
      assert mm[{15, 20}] == 8
      assert mm[{19, 20}] == 5
      assert mm[{19, 25}] == 1
      assert mm[{19, 29}] == 4
      assert mm[{15, 29}] == 7
      assert mm[{10, 29}] == 5
      assert mm[{10, 25}] == 4
    end
  end
end
