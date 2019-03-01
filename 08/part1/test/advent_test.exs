defmodule AdventTest do
  use ExUnit.Case

  defp example_input() do
    {:ok, dev} = File.open("input/example.txt")
    dev
  end

  test "read_input" do
    assert Advent.read_input(example_input()) == [
      2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2
    ]
  end

  test "eval" do
    assert Advent.read_input(example_input())
           |> Advent.eval == 138
  end

end
