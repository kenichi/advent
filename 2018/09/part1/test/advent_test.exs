defmodule AdventTest do
  use ExUnit.Case

  describe "eval" do

    test "eval with 9 and 25" do
      assert Advent.eval(9, 25) == 32
    end

    test "eval with 10 and 1618" do
      assert Advent.eval(10, 1618) == 8317
    end

    test "eval with 13 and 7999" do
      assert Advent.eval(13, 7999) == 146373
    end

    test "eval with 17 and 1104" do
      assert Advent.eval(17, 1104) == 2764
    end

    test "eval with 21 and 6111" do
      assert Advent.eval(21, 6111) == 54718
    end

    test "eval with 30 and 5807" do
      assert Advent.eval(30, 5807) == 37305
    end

  end

end
