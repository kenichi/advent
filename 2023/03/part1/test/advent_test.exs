defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  setup _, do: %{input: Advent.Input.parse(@test_input)}

  test "part numbers sum", %{input: input} do
    assert Advent.part_numbers_sum(input) == 4361
  end
end
