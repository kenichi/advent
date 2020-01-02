defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "list to map and state to list" do
    ri = Advent.Input.read()
    assert %Advent.Intcode{state: Advent.list_to_map(ri)} |> Advent.state_to_list() == ri
  end
end
