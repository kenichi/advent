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
    %Advent{state: [3, 0, 4, 0, 99], input: ["fortytwo"]}
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

  test "positional equal to 8" do
    eq8 = %Advent{state: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]}

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "positional less than 8" do
    lt8 = %Advent{state: [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]}

    assert %Advent{lt8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{lt8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{lt8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "immediate equal to 8" do
    eq8 = %Advent{state: [3, 3, 1108, -1, 8, 3, 4, 3, 99]}

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "immediate less than 8" do
    lt8 = %Advent{state: [3, 3, 1107, -1, 8, 3, 4, 3, 99]}

    assert %Advent{lt8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{lt8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{lt8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "positional input equal to 0" do
    eq0 = %Advent{state: [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]}

    assert %Advent{eq0 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq0 | input: [0]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq0 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1
  end

  test "immediate input equal to 0" do
    eq0 = %Advent{state: [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]}

    assert %Advent{eq0 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq0 | input: [0]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq0 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1
  end

  test "equal to 8" do
    eq8 = %Advent{
      state: [
        3,
        21,
        1008,
        21,
        8,
        20,
        1005,
        20,
        22,
        107,
        8,
        21,
        20,
        1006,
        20,
        31,
        1106,
        0,
        36,
        98,
        0,
        0,
        1002,
        21,
        125,
        20,
        4,
        20,
        1105,
        1,
        46,
        104,
        999,
        1105,
        1,
        46,
        1101,
        1000,
        1,
        20,
        4,
        20,
        1105,
        1,
        46,
        98,
        99
      ]
    }

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 999
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1000
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1001
  end
end
