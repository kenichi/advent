defmodule AdventTest do
  use ExUnit.Case

  @input """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """

  test "read_input" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) == [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]
  end

  test "parse_input" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev)
           |> Advent.parse_input() == [
      %Claim{id: 1, origin: {1,3}, size: {4,4}},
      %Claim{id: 2, origin: {3,1}, size: {4,4}},
      %Claim{id: 3, origin: {5,5}, size: {2,2}}
    ]
  end

  test "apply_claim" do
    assert Advent.apply_claim(%Claim{id: 1, origin: {1,3}, size: {2,2}}) == [{1,3},{1,4},{2,3},{2,4}]
  end

  test "count_shared_squares" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev)
           |> Advent.parse_input
           |> Advent.count_shared_squares == 4
  end

end
