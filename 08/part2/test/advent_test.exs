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
           |> Advent.eval == 66
  end

  describe "node_value" do

    test "a" do
      {_, a} = Advent.parse_header(
        %Advent.Input{ data: Advent.read_input(example_input()) })
      assert Advent.node_value(a) == 66
    end

    test "b" do
      {_, a} = Advent.parse_header(
        %Advent.Input{ data: Advent.read_input(example_input()) })
      b = Enum.at(a.children, 0)
      assert Advent.node_value(b) == 33
    end

    test "c" do
      {_, a} = Advent.parse_header(
        %Advent.Input{ data: Advent.read_input(example_input()) })
      c = Enum.at(a.children, 1)
      assert Advent.node_value(c) == 0
    end

    test "d" do
      {_, a} = Advent.parse_header(
        %Advent.Input{ data: Advent.read_input(example_input()) })
      d = Enum.at(Enum.at(a.children, 1).children, 0)
      assert Advent.node_value(d) == 99
    end

  end

end
