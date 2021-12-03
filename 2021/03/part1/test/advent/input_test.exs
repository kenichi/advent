defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses binaries correctly" do
      observed = Advent.Input.parse([
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
      ])

      expected = [
        {0,0,1,0,0},
        {1,1,1,1,0},
        {1,0,1,1,0},
        {1,0,1,1,1},
        {1,0,1,0,1},
        {0,1,1,1,1},
        {0,0,1,1,1},
        {1,1,1,0,0},
        {1,0,0,0,0},
        {1,1,0,0,1},
        {0,0,0,1,0},
        {0,1,0,1,0}
      ]

      assert observed == expected
    end
  end
end
