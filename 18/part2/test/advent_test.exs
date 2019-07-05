defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "minutes" do
    expected = Advent.parse("input/10_mins.txt")
    observed =
      Advent.parse("input/example.txt")
      |> Advent.minutes(10)
    assert observed == expected
  end

end
