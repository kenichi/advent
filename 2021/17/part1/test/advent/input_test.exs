defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      assert TestHelpers.parsed_example() == [20, 30, -10, -5]
    end
  end
end
