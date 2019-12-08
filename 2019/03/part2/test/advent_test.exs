defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  @example_1 [
    ["R8", "U5", "L5", "D3"],
    ["U7", "R6", "D4", "L4"]
  ]

  test "parse_dir" do
    expected = [
      [{:R, 8}, {:U, 5}, {:L, 5}, {:D, 3}],
      [{:U, 7}, {:R, 6}, {:D, 4}, {:L, 4}]
    ]

    observed =
      Enum.map(@example_1, fn line ->
        Enum.map(line, &Advent.parse_dir/1)
      end)

    assert expected == observed
  end

  test "example 1" do
    assert Advent.eval(@example_1) == 30
  end
end
