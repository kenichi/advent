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
    assert Advent.calculate_priority_sum(input) == 157
  end

  test "split_and_fetch_item_priority/1", %{input: [a, b, c, d, e, f]} do
    assert Advent.split_and_fetch_item_priority(a) == 16
    assert Advent.split_and_fetch_item_priority(b) == 38
    assert Advent.split_and_fetch_item_priority(c) == 42
    assert Advent.split_and_fetch_item_priority(d) == 22
    assert Advent.split_and_fetch_item_priority(e) == 20
    assert Advent.split_and_fetch_item_priority(f) == 19
  end
end
