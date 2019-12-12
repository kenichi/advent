defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "builds layers" do
    assert Advent.layers([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2], 3, 2) ==
      [
        [
          [1, 2, 3],
          [4, 5, 6]
        ],
        [
          [7, 8, 9],
          [0, 1, 2]
        ],
      ]
  end
end
