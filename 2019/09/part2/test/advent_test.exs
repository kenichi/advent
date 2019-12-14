defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "example 1" do
    state = %Advent{state: Advent.list_to_map([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50])}
    observed = Advent.operate(state) |> Advent.state_to_list()
    expected = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
    assert observed == expected
  end

  test "example 2" do
    state = %Advent{state: Advent.list_to_map([1, 0, 0, 0, 99])}
    observed = Advent.operate(state) |> Advent.state_to_list()
    expected = [2, 0, 0, 0, 99]
    assert observed == expected
  end

  test "example 3" do
    state = %Advent{state: Advent.list_to_map([2, 3, 0, 3, 99])}
    observed = Advent.operate(state) |> Advent.state_to_list()
    expected = [2, 3, 0, 6, 99]
    assert observed == expected
  end

  test "example 4" do
    state = %Advent{state: Advent.list_to_map([2, 4, 4, 5, 99, 0])}
    observed = Advent.operate(state) |> Advent.state_to_list()
    expected = [2, 4, 4, 5, 99, 9801]
    assert observed == expected
  end

  test "example 5" do
    state = %Advent{state: Advent.list_to_map([1, 1, 1, 4, 99, 5, 6, 0, 99])}
    observed = Advent.operate(state) |> Advent.state_to_list()
    expected = [30, 1, 1, 4, 2, 5, 6, 0, 99]
    assert observed == expected
  end

  test "3,0,4,0,99 outputs whatever it gets as input, then halts" do
    %Advent{state: Advent.list_to_map([3, 0, 4, 0, 99]), input: ["fortytwo"]}
    |> Advent.operate()
    |> (fn %Advent{output: o} -> o == ["fortytwo"] end).()
    |> assert
  end

  test "1002,4,3,4,33 writes 99 to 4 and halts" do
    observed =
      %Advent{state: Advent.list_to_map([1002, 4, 3, 4, 33])}
      |> Advent.operate()
      |> Advent.state_to_list()

    assert observed == [1002, 4, 3, 4, 99]
  end

  test "positional equal to 8" do
    eq8 = %Advent{state: Advent.list_to_map([3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8])}

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "positional less than 8" do
    lt8 = %Advent{state: Advent.list_to_map([3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8])}

    assert %Advent{lt8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{lt8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{lt8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "immediate equal to 8" do
    eq8 = %Advent{state: Advent.list_to_map([3, 3, 1108, -1, 8, 3, 4, 3, 99])}

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "immediate less than 8" do
    lt8 = %Advent{state: Advent.list_to_map([3, 3, 1107, -1, 8, 3, 4, 3, 99])}

    assert %Advent{lt8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{lt8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{lt8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 0
  end

  test "positional input equal to 0" do
    eq0 = %Advent{
      state: Advent.list_to_map([3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9])
    }

    assert %Advent{eq0 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq0 | input: [0]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq0 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1
  end

  test "immediate input equal to 0" do
    eq0 = %Advent{state: Advent.list_to_map([3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1])}

    assert %Advent{eq0 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 1
    assert %Advent{eq0 | input: [0]} |> Advent.operate() |> Advent.first_output() == 0
    assert %Advent{eq0 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1
  end

  test "equal to 8" do
    eq8 = %Advent{
      state:
        Advent.list_to_map([
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
        ])
    }

    assert %Advent{eq8 | input: [-1]} |> Advent.operate() |> Advent.first_output() == 999
    assert %Advent{eq8 | input: [8]} |> Advent.operate() |> Advent.first_output() == 1000
    assert %Advent{eq8 | input: [9]} |> Advent.operate() |> Advent.first_output() == 1001
  end

  test "list to map and state to list" do
    ri = Advent.read_input()
    assert %Advent{state: Advent.list_to_map(ri)} |> Advent.state_to_list() == ri
  end

  test "base 2000" do
    state = %Advent{
      relative_base: 2000,
      state: %{
        0 => 109,
        1 => 19,
        2 => 204,
        3 => -34,
        4 => 99,
        1985 => 31337
      }
    }

    assert Advent.operate(state).output == [31337]
  end

  test "copies itself" do
    expected = [109, 1, 204, -1, 1001, 100, 1, 100, 1008, 100, 16, 101, 1006, 101, 0, 99]

    observed =
      %Advent{state: Advent.list_to_map(expected)}
      |> Advent.operate()

    assert observed.output == expected
  end

  test "sixteen digit output" do
    state = %Advent{state: Advent.list_to_map([1102, 34_915_192, 34_915_192, 7, 4, 7, 99, 0])}
    observed = Advent.operate(state) |> Advent.first_output()
    assert Integer.digits(observed) |> length() == 16
  end

  test "output large number" do
    state = %Advent{state: Advent.list_to_map([104, 1_125_899_906_842_624, 99])}
    observed = Advent.operate(state) |> Advent.first_output()
    assert observed == 1_125_899_906_842_624
  end
end
