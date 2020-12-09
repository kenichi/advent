defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  @input """
  FBFBBFFRLR
  BFFFBBFRRR
  FFFBBBFRRR
  BBFFBBFRLL
  """

  describe "Advent.eval/1" do
    test "returns highest seat id" do
      observed =
        String.split(@input, "\n", trim: true)
        |> Advent.eval()

      assert observed == 820
    end
  end
end
