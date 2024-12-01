defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "similarity_score/1", %{input: input} do
    assert similarity_score(input) == 31
  end
end
