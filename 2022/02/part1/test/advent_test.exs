defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  A Y
  B X
  C Z
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "calculates score", %{input: input} do
    assert Advent.calculate_score(input) == 15
  end
end
