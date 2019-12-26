defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Field
  doctest Advent.Field.Laser
  doctest Advent.Input

  def test_best_station(input) do
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
      |> test_best_station()

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
      |> test_best_station()

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
      |> test_best_station()

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
      |> test_best_station()

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
      |> test_best_station()

    assert observed == {{11, 13}, 210}
  end

  test "200th" do
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
      |> StringIO.open()
      |> (fn {:ok, dev} -> Advent.Input.read(dev) end).()
      |> Advent.Input.parse()
      |> Advent.field_with_best_station()
      |> Advent.two_hundreth()

    assert observed == {8, 2}
  end

  test "quadrant" do
    assert Advent.Field.Laser.quadrant({2, 3}, {2, 0}) == 0
    assert Advent.Field.Laser.quadrant({2, 3}, {4, 0}) == 0
    assert Advent.Field.Laser.quadrant({2, 3}, {5, 3}) == 1
    assert Advent.Field.Laser.quadrant({2, 3}, {4, 4}) == 1
    assert Advent.Field.Laser.quadrant({2, 3}, {2, 5}) == 2
    assert Advent.Field.Laser.quadrant({2, 3}, {1, 5}) == 2
    assert Advent.Field.Laser.quadrant({2, 3}, {0, 3}) == 3
    assert Advent.Field.Laser.quadrant({2, 3}, {1, 1}) == 3
  end

  test "slope" do
    assert Advent.Field.Laser.slope({2, 3}, {3, 0}) == -3
    assert Advent.Field.Laser.slope({2, 3}, {3, 1}) == -2
    assert Advent.Field.Laser.slope({2, 3}, {4, 0}) == -1.5
    assert Advent.Field.Laser.slope({2, 3}, {5, 3}) == 0
    assert Advent.Field.Laser.slope({2, 3}, {4, 4}) == 0.5
    assert Advent.Field.Laser.slope({2, 3}, {3, 5}) == 2
    assert Advent.Field.Laser.slope({2, 3}, {1, 1}) == 2
    assert Advent.Field.Laser.slope({2, 3}, {0, 3}) == 0
    assert Advent.Field.Laser.slope({2, 3}, {1, 5}) == -2
    assert Advent.Field.Laser.slope({2, 3}, {4, 2}) == -0.5
    assert Advent.Field.Laser.slope({2, 3}, {0, 4}) == -0.5
  end
end
