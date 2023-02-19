defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  """

  describe "Advent.Input" do
    test "parse/1" do
      assert Advent.Input.parse(@test_input) ==
               MapSet.new([
                 {498, 4},
                 {498, 5},
                 {498, 6},
                 {497, 6},
                 {496, 6},
                 {503, 4},
                 {502, 4},
                 {502, 5},
                 {502, 6},
                 {502, 7},
                 {502, 8},
                 {502, 9},
                 {501, 9},
                 {500, 9},
                 {499, 9},
                 {498, 9},
                 {497, 9},
                 {496, 9},
                 {495, 9},
                 {494, 9}
               ])
    end
  end

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "full_sand_units/1", %{input: input} do
      assert Advent.full_sand_units(input) == 93
    end
  end
end
