defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      observed = TestHelpers.parsed_example()

      expected = %{
        8 => 0,
        7 => 0,
        6 => 0,
        5 => 0,
        4 => 1,
        3 => 2,
        2 => 1,
        1 => 1,
        0 => 0
      }

      assert observed == expected
    end
  end
end
