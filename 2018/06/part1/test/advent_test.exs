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

  test "closest_index" do
    assert Advent.closest_index(@input, {0,0}) == {:single, 0}
    assert Advent.closest_index(@input, {0,5}) == {:single, 1}
    assert Advent.closest_index(@input, {0,4}) == {:multi, nil}
  end

  test "eval" do
    assert Advent.eval(@input) == 17
  end

end
