defmodule AdventTest do
  use ExUnit.Case

  describe "Advent.eval/1" do
    test "example input" do
      observed = Advent.eval([
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
      ])

      expected = 198
      
      assert observed == expected
    end
  end
end
