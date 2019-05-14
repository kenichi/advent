defmodule AdventTest do
  use ExUnit.Case

  test "eval" do
    assert Advent.eval("input/example.txt") == 325
  end

end
