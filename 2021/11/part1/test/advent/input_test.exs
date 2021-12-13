defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      ex = TestHelpers.parsed_example()

      assert ex[{0,0}] == 5
      assert ex[{9,0}] == 3
      assert ex[{0,9}] == 5
      assert ex[{9,9}] == 6
    end
  end
end
