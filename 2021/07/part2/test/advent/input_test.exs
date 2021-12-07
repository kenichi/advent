defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      observed = TestHelpers.parsed_example()

      expected = [16,1,2,0,4,2,7,1,2,14]

      assert observed == expected
    end
  end
end
