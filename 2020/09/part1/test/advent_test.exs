defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  @input """
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  """

  describe "Advent.eval/1" do
    test "returns first number that is invalid xmas(5)" do
      observed =
        String.split(@input, "\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Advent.eval(5)

      assert observed == 127
    end
  end
end
