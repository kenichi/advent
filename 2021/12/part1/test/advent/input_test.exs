defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input 1" do
      assert TestHelpers.parsed_example() == [
        {"start", "A"},
        {"start", "b"},
        {"A", "c"},
        {"A", "b"},
        {"b", "d"},
        {"A", "end"},
        {"b", "end"}
      ]
    end

    test "parses input 2" do
      assert TestHelpers.parsed_example(TestHelpers.example_2()) == [
        {"dc", "end"},
        {"HN", "start"},
        {"start", "kj"},
        {"dc", "start"},
        {"dc", "HN"},
        {"LN", "dc"},
        {"HN", "end"},
        {"kj", "sa"},
        {"kj", "HN"},
        {"kj", "dc"}
      ]
    end
  end
end
