defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "calibration sum", %{input: input} do
    assert Advent.calibration_sum(input) == 142
  end
end
