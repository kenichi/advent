defmodule AdventTest do
  use ExUnit.Case

  @doc """
                                 1  1  1  1  1  1  1  1  1  1
   0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5  6  7  8  9
  ===========================================================
  (3)[7]
  (3)[7] 1  0 
   3  7  1 [0](1) 0 
   3  7  1  0 [1] 0 (1)
  (3) 7  1  0  1  0 [1] 2 
   3  7  1  0 (1) 0  1  2 [4]
   3  7  1 [0] 1  0 (1) 2  4  5 
   3  7  1  0 [1] 0  1  2 (4) 5  1 
   3 (7) 1  0  1  0 [1] 2  4  5  1  5 
   3  7  1  0  1  0  1  2 [4](5) 1  5  8 
   3 (7) 1  0  1  0  1  2  4  5  1  5  8 [9]
   3  7  1  0  1  0  1 [2] 4 (5) 1  5  8  9  1  6 
   3  7  1  0  1  0  1  2  4  5 [1] 5  8  9  1 (6) 7 
   3  7  1  0 (1) 0  1  2  4  5  1  5 [8] 9  1  6  7  7 

   3  7 [1] 0  1  0 (1) 2  4  5  1  5  8  9  1  6  7  7  9 
   3  7  1  0 [1] 0  1  2 (4) 5  1  5  8  9  1  6  7  7  9  2
  """

  test "new_recipe" do
    alias Advent.Score

    {s, e} = Advent.new_recipe({Score.new([3, 7]), [0, 1]})
    assert {Score.to_list(s), e} == {[3, 7, 1, 0], [0, 1]}

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0],
      [4, 3]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1],
      [6, 4]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2],
      [0, 6]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4],
      [4, 8]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5],
      [6, 3]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1],
      [8, 4]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5],
      [1, 6]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8],
      [9, 8]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9],
      [1, 13]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9, 1, 6],
      [9, 7]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9, 1, 6, 7],
      [15, 10]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9, 1, 6, 7, 7],
      [4, 12]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9, 1, 6, 7, 7, 9],
      [6, 2]
    }

    {s, e} = Advent.new_recipe({s, e})
    assert {Score.to_list(s), e} == {
      [3, 7, 1, 0, 1, 0, 1, 2, 4, 5, 1, 5, 8, 9, 1, 6, 7, 7, 9, 2],
      [8, 4]
    }

  end

  test "eval_nine" do
    assert Advent.eval("51589") == 9
  end

  test "eval_five" do
    assert Advent.eval("01245") == 5
  end

  test "eval eighteen" do
    assert Advent.eval("92510") == 18
  end

  test "eval twenty eighteen" do
    assert Advent.eval("59414") == 2018
  end

end
