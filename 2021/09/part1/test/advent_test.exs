defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 15

      assert observed == expected
    end
  end
end
