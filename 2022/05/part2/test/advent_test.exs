defmodule AdventTest do
  use ExUnit.Case

  @test_input "    [D]    \n" <>
                "[N] [C]    \n" <>
                "[Z] [M] [P]\n" <>
                " 1   2   3 \n" <>
                "\n" <>
                "move 1 from 2 to 1\n" <>
                "move 3 from 1 to 3\n" <>
                "move 2 from 2 to 1\n" <>
                "move 1 from 1 to 2\n"

  describe("Advent.Input.parse/1") do
    test "parse/1" do
      assert Advent.Input.parse(@test_input) == {
               %{0 => ~w[N Z], 1 => ~w[D C M], 2 => ~w[P]},
               [{1, 1, 0}, {3, 0, 2}, {2, 1, 0}, {1, 0, 1}]
             }
    end
  end

  describe "Advent.stack_supplies/1" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "stack_supplies/1", %{input: input} do
      assert Advent.stack_supplies(input) == "MCD"
    end
  end
end
