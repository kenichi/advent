defmodule AdventTest do
  use ExUnit.Case

  @input [{1, 1},{1, 6},{8, 3},{3, 4},{5, 5},{8, 9}]

  test "read_input" do
    {:ok, dev} = StringIO.open("""
      1, 2
      3, 4
      """)
    assert Advent.read_input(dev) == [{1,2}, {3,4}]
  end

  test "md" do
    assert Advent.md({1,1}, {3,3}) == 4
    assert Advent.md({-3,-3}, {2,1}) == 9
    assert Advent.md({2,1}, {-3,-3}) == 9
    assert Advent.md({-3,3}, {2,-1}) == 9
    assert Advent.md({2,-1}, {-3,3}) == 9
  end

  test "max_x" do
    assert Advent.max_x(@input) == 8
  end

  test "min_x" do
    assert Advent.min_x(@input) == 1
  end

  test "max_y" do
    assert Advent.max_y(@input) == 9
  end

  test "min_y" do
    assert Advent.min_y(@input) == 1
  end

  test "aggregate_distance" do
    assert Advent.aggregate_distance(@input, {4,3}) == 30
  end

  test "eval" do
    assert Advent.eval(@input) == 16
  end

end
