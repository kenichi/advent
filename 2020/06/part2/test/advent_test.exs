defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  @input """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  describe "Advent.eval/1" do
    test "returns sum of yes answers by whole group" do
      observed =
        String.split(@input, "\n\n", trim: true)
        |> Advent.Input.parse()
        |> Advent.eval()

      assert observed == 6
    end
  end
end
