defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "mul_sum/1", %{input: input} do
    assert mul_sum(input) == 48
  end
end
