defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses instructions correctly" do
      observed = Advent.Input.parse([
        "forward 5",
        "down 5",
        "forward 8",
        "up 3", 
        "down 8",
        "forward 2"
      ])

      expected = [{:f, 5}, {:d, 5}, {:f, 8}, {:u, 3}, {:d, 8}, {:f, 2}]
      assert observed == expected
    end
  end
end
