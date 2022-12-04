defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "count_containments/1", %{input: input} do
    assert Advent.count_containments(input) == 2
  end
end
