defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example single input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 5353

      assert observed == expected
    end

    test "example multi input" do
      observed =
        TestHelpers.parsed_example(:multi)
        |> Advent.eval()

      expected = 61229

      assert observed == expected
    end
  end
end
