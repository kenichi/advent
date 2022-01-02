defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example inputs" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 45

      assert observed == expected
    end
  end
end
