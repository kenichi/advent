defmodule AdventTest do
  use ExUnit.Case

  test "eval" do
    assert {7, 3} == Advent.eval("input/example.txt")
  end

end
