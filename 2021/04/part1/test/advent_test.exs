defmodule AdventTest do
  use ExUnit.Case
  doctest Advent.Board

  describe "Advent.eval/1" do
    test "example input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 4512

      assert observed == expected
    end
  end
end
