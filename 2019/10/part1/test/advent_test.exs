defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Field
  doctest Advent.Input

  def test_map(input) do
    input
    |> StringIO.open()
    |> (fn {:ok, dev} -> Advent.Input.read(dev) end).()
    |> Advent.Input.parse()
    |> Advent.best_station()
  end

  test "example 1" do
    observed =
      """
      .#..#
      .....
      #####
      ....#
      ...##
      """
      |> test_map()

    assert observed == {{3, 4}, 8}
  end

  test "example 2" do
    observed =
      """
      ......#.#.
      #..#.#....
      ..#######.
      .#.#.###..
      .#..#.....
      ..#....#.#
      #..#....#.
      .##.#..###
      ##...#..#.
      .#....####
      """
      |> test_map()

    assert observed == {{5, 8}, 33}
  end

  test "example 3" do
    observed =
      """
      #.#...#.#.
      .###....#.
      .#....#...
      ##.#.#.#.#
      ....#.#.#.
      .##..###.#
      ..#...##..
      ..##....##
      ......#...
      .####.###.
      """
      |> test_map()

    assert observed == {{1, 2}, 35}
  end

  test "example 4" do
    observed =
      """
      .#..#..###
      ####.###.#
      ....###.#.
      ..###.##.#
      ##.##.#.#.
      ....###..#
      ..#.#..#.#
      #..#.#.###
      .##...##.#
      .....#.#..
      """
      |> test_map()

    assert observed == {{6, 3}, 41}
  end

  test "example 5" do
    observed =
      """
      .#..##.###...#######
      ##.############..##.
      .#.######.########.#
      .###.#######.####.#.
      #####.##.#.##.###.##
      ..#####..#.#########
      ####################
      #.####....###.#.#.##
      ##.#################
      #####.##.###..####..
      ..######..##.#######
      ####.##.####...##..#
      .#####..#.######.###
      ##...#.##########...
      #.##########.#######
      .####.#.###.###.#.##
      ....##.##.###..#####
      .#.#.###########.###
      #.#.#.#####.####.###
      ###.##.####.##.#..##
      """
      |> test_map()

    assert observed == {{11, 13}, 210}
  end
end
