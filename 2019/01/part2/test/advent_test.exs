defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "calculates correct fuel requirements" do
    assert Advent.total_fuel_for(14) == 2
    assert Advent.total_fuel_for(1_969) == 966
    assert Advent.total_fuel_for(100_756) == 50_346
  end
end
