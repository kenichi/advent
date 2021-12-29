defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def eval_example(which) do
    TestHelpers.example_input(which)
    |> TestHelpers.parsed_example()
    |> Advent.eval()
  end

  describe "Advent.eval/1" do
    test "example inputs" do
      assert eval_example(1) == 6
      assert eval_example(2) == 9
      assert eval_example(3) == 14
      assert eval_example(4) == 16
      assert eval_example(5) == 12
      assert eval_example(6) == 23
      assert eval_example(7) == 31
    end
  end
end
