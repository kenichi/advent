defmodule AdventTest do
  use ExUnit.Case

  defp example_input() do
    {:ok, dev} = File.open("input/example.txt")
    dev
  end

  test "read_input" do
    assert Advent.read_input(example_input()) == [
      {[ 9, 1], [ 0, 2]},
      {[ 7, 0], [-1, 0]},
      {[ 3,-2], [-1, 1]},
      {[ 6,10], [-2,-1]},
      {[ 2,-4], [ 2, 2]},
      {[-6,10], [ 2,-2]},
      {[ 1, 8], [ 1,-1]},
      {[ 1, 7], [ 1, 0]},
      {[-3,11], [ 1,-2]},
      {[ 7, 6], [-1,-1]},
      {[-2, 3], [ 1, 0]},
      {[-4, 3], [ 2, 0]},
      {[10,-3], [-1, 1]},
      {[ 5,11], [ 1,-2]},
      {[ 4, 7], [ 0,-1]},
      {[ 8,-2], [ 0, 1]},
      {[15, 0], [-2, 0]},
      {[ 1, 6], [ 1, 0]},
      {[ 8, 9], [ 0,-1]},
      {[ 3, 3], [-1, 1]},
      {[ 0, 5], [ 0,-1]},
      {[-2, 2], [ 2, 0]},
      {[ 5,-2], [ 1, 2]},
      {[ 1, 4], [ 2, 1]},
      {[-2, 7], [ 2,-2]},
      {[ 3, 6], [-1,-1]},
      {[ 5, 0], [ 1, 0]},
      {[-6, 0], [ 2, 0]},
      {[ 5, 9], [ 1,-2]},
      {[14, 7], [-2, 0]},
      {[-3, 6], [ 2,-1]}
    ]
  end

  test "move_light" do
    assert Advent.move_light({[ 9, 1], [ 0, 2]}) == {[9,3], [0,2]}
    assert Advent.move_light({[ 6,10], [-2,-1]}) == {[4,9], [-2,-1]}
  end

  test "eval" do
    assert true
  end

end
