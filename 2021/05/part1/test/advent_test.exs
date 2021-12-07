defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 5

      assert observed == expected
    end
  end

  describe "Advent.points/1" do
    test "northeast" do
      assert Advent.points({{0,0},{2,2}}) ==
        [{0,0}, {1,1}, {2,2}]
    end

    test "southwest" do
      assert Advent.points({{2,4},{0,0}}) ==
        [{2,4}, {1,2}, {0,0}]
    end

    test "north" do
      assert Advent.points({{0,0},{0,2}}) ==
        [{0,0}, {0,1}, {0,2}]
    end
  end

  describe "Advent.slope/2 - run/rise" do
    test "east" do
      assert Advent.slope(4, 0) == {1, 0}
    end

    test "west" do
      assert Advent.slope(-4, 0) == {-1, 0}
    end

    test "north" do
      assert Advent.slope(0, 4) == {0, 1}
    end

    test "south" do
      assert Advent.slope(0, -4) == {0, -1}
    end

    test "southeast" do
      assert Advent.slope(2, -4) == {1, -2}
    end

    test "southwest" do
      assert Advent.slope(-2, -4) == {-1, -2}
    end

    test "northeast" do
      assert Advent.slope(2, 4) == {1, 2}
    end

    test "northwest" do
      assert Advent.slope(-2, 4) == {-1, 2}
    end
  end

  describe "Advent.gcd/2" do
    test "works" do
      assert Advent.gcd(48, 18) == 6
    end
  end
end
