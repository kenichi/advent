defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  125 17
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "stone_count/2", %{input: input} do
    assert stone_count(input, 25) == 55312
  end
end
