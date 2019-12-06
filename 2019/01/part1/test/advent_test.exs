defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "calculates correct fuel requirements" do
    assert Advent.fuel_for(12) == 2
    assert Advent.fuel_for(14) == 2
    assert Advent.fuel_for(1969) == 654
    assert Advent.fuel_for(100_756) == 33583
  end
end
