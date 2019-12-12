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

    assert Advent.layers([0, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 2, 0, 0, 0, 0], 2, 2) ==
      [
        [
          [0, 2],
          [2, 2]
        ],
        [
          [1, 1],
          [2, 2]
        ],
        [
          [2, 2],
          [1, 2]
        ],
        [
          [0, 0],
          [0, 0]
        ]
      ]
  end

  test "combines layers" do
    observed =
      Advent.layers([0, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 2, 0, 0, 0, 0], 2, 2)
      |> Advent.combine()

    assert observed == [[0, 1], [1, 0]]
  end
end
