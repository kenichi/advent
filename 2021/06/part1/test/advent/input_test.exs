defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      observed = TestHelpers.parsed_example()

      expected = [3,4,3,1,2]

      assert observed == expected
    end
  end
end
