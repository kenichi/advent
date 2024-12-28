defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  89010123
  78121874
  87430965
  96549874
  45678903
  32019012
  01329801
  10456732
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "score_sum/1", %{input: input} do
    assert score_sum(input) == 36
  end
end
