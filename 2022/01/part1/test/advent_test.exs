defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "counts calories", %{input: input} do
    assert Advent.count_calories(input) == 24_000
  end
end
