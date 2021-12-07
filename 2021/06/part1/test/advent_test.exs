defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example input 18" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval(18)

      expected = 26

      assert observed == expected
    end

    test "example input 80" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 5934

      assert observed == expected
    end
  end
end
