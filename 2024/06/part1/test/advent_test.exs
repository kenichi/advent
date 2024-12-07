defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "distinct_positions/1", %{input: input} do
    assert distinct_positions(input) == 41
  end
end
