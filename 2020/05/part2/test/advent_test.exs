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
    test "returns unused seat id" do
      # no exmamples to test :(
      assert true
    end
  end
end
