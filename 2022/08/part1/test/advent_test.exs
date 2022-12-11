defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  30373
  25512
  65332
  33549
  35390
  """

  describe "Advent.Input" do
    test "parse/1" do
      assert Advent.Input.parse(@test_input) == %{
               {0, 0} => 3,
               {1, 0} => 0,
               {2, 0} => 3,
               {3, 0} => 7,
               {4, 0} => 3,
               {0, 1} => 2,
               {1, 1} => 5,
               {2, 1} => 5,
               {3, 1} => 1,
               {4, 1} => 2,
               {0, 2} => 6,
               {1, 2} => 5,
               {2, 2} => 3,
               {3, 2} => 3,
               {4, 2} => 2,
               {0, 3} => 3,
               {1, 3} => 3,
               {2, 3} => 5,
               {3, 3} => 4,
               {4, 3} => 9,
               {0, 4} => 3,
               {1, 4} => 5,
               {2, 4} => 3,
               {3, 4} => 9,
               {4, 4} => 0
             }
    end
  end

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "visible_trees/1", %{input: input} do
      assert Advent.visible_trees(input) == 21
    end
  end
end
