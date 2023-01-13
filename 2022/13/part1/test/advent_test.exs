defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]
  """

  describe "Advent.Input" do
    test "parse/1" do
      assert Advent.Input.parse(@test_input) == [
               [
                 [1, 1, 3, 1, 1],
                 [1, 1, 5, 1, 1]
               ],
               [
                 [[1], [2, 3, 4]],
                 [[1], 4]
               ],
               [
                 [9],
                 [[8, 7, 6]]
               ],
               [
                 [[4, 4], 4, 4],
                 [[4, 4], 4, 4, 4]
               ],
               [
                 [7, 7, 7, 7],
                 [7, 7, 7]
               ],
               [
                 [],
                 [3]
               ],
               [
                 [[[]]],
                 [[]]
               ],
               [
                 [1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
                 [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]
               ]
             ]
    end
  end

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "ordered_pair_index_sum/1", %{input: input} do
      assert Advent.ordered_pair_index_sum(input) == 13
    end
  end
end
