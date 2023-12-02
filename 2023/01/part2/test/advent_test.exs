defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "calibration sum", %{input: input} do
    assert Advent.calibration_sum(input) == 281
  end
end
