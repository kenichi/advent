defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "calculates priority sum", %{input: input} do
    assert Advent.calculate_priority_sum(input) == 70
  end
end
