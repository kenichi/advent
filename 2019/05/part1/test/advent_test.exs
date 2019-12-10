defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "example 1" do
    state = %Advent{state: [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]}
    expected = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
    assert Advent.operate(state).state == expected
  end

  test "example 2" do
    state = %Advent{state: [1, 0, 0, 0, 99]}
    expected = [2, 0, 0, 0, 99]
    assert Advent.operate(state).state == expected
  end

  test "example 3" do
    state = %Advent{state: [2, 3, 0, 3, 99]}
    expected = [2, 3, 0, 6, 99]
    assert Advent.operate(state).state == expected
  end

  test "example 4" do
    state = %Advent{state: [2, 4, 4, 5, 99, 0]}
    expected = [2, 4, 4, 5, 99, 9801]
    assert Advent.operate(state).state == expected
  end

  test "example 5" do
    state = %Advent{state: [1, 1, 1, 4, 99, 5, 6, 0, 99]}
    expected = [30, 1, 1, 4, 2, 5, 6, 0, 99]
    assert Advent.operate(state).state == expected
  end

  test "3,0,4,0,99 outputs whatever it gets as input, then halts" do
    %Advent{state: [3, 0, 4, 0, 99], input: "fortytwo"}
    |> Advent.operate()
    |> (fn %Advent{output: o} -> o == ["fortytwo"] end).()
    |> assert
  end

  test "1002,4,3,4,33 writes 99 to 4 and halts" do
    observed =
      %Advent{state: [1002, 4, 3, 4, 33]}
      |> Advent.operate()

    assert observed.state == [1002, 4, 3, 4, 99]
  end
end
