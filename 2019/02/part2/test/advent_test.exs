defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "example 1" do
    istate = [1,9,10,3,2,3,11,0,99,30,40,50]
    result = [3500,9,10,70,2,3,11,0,99,30,40,50]
    assert Advent.operate(istate) == result
  end

  test "example 2" do
    istate = [1,0,0,0,99]
    result = [2,0,0,0,99]
    assert Advent.operate(istate) == result
  end

  test "example 3" do
    istate = [2,3,0,3,99]
    result = [2,3,0,6,99]
    assert Advent.operate(istate) == result
  end

  test "example 4" do
    istate = [2,4,4,5,99,0]
    result = [2,4,4,5,99,9801]
    assert Advent.operate(istate) == result
  end

  test "example 5" do
    istate = [1,1,1,4,99,5,6,0,99]
    result = [30,1,1,4,2,5,6,0,99]
    assert Advent.operate(istate) == result
  end
end
