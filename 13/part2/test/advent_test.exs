defmodule AdventTest do
  use ExUnit.Case

  test "eval" do
    assert {6, 4} == Advent.eval("input/example.txt")
  end

end
