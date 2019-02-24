defmodule AdventTest do
  use ExUnit.Case

  @input """
  Step C must be finished before step A can begin.
  Step C must be finished before step F can begin.
  Step A must be finished before step B can begin.
  Step A must be finished before step D can begin.
  Step B must be finished before step E can begin.
  Step D must be finished before step E can begin.
  Step F must be finished before step E can begin.
  """

  test "read_input" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) == [
      "Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin."
    ]
  end

  test "eval" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev)
           |> Advent.parse_input
           |> Advent.build_deps
           |> Advent.eval == 15
  end

  test "step" do
    assert Advent.Step.duration(%Advent.Step{ id: "A" }) == 1
    assert Advent.Step.duration(%Advent.Step{ id: "M" }) == 13
    assert Advent.Step.duration(%Advent.Step{ id: "Z" }) == 26
  end

end
