defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  @input """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  describe "Advent.eval/1" do
    test "returns value in accumulator before repeat instruction" do
      observed =
        String.split(@input, "\n", trim: true)
        |> Advent.Input.parse()
        |> Advent.eval()

      assert observed == 5
    end
  end
end
