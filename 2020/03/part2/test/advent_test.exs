defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  @input """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  describe "Advent.eval/1" do
    test "counts trees in slopes" do
      observed =
        String.split(@input)
        |> Advent.Input.parse()
        |> Advent.eval()

      assert observed == 336
    end
  end
end
