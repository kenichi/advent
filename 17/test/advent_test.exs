defmodule AdventTest do
  use ExUnit.Case

  test "eval" do
    assert Advent.eval("input/example.txt") == %{
      total: 57,
      pool: 29
    }
  end
end
