defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def sum_example(which) do
    TestHelpers.example_input(which)
    |> TestHelpers.parsed_example()
    |> Advent.sum_packet_versions()
  end

  describe "Advent.sum_packet_versions/1" do
    test "example inputs" do
      assert sum_example(1) == 6
      assert sum_example(2) == 9
      assert sum_example(3) == 14
      assert sum_example(4) == 16
      assert sum_example(5) == 12
      assert sum_example(6) == 23
      assert sum_example(7) == 31
    end
  end

  def eval_example(which) do
    TestHelpers.example_input(which)
    |> TestHelpers.parsed_example()
    |> Advent.eval()
  end

  describe "Advent.eval/1" do
    test "example inputs" do
      assert eval_example(8) == 3
      assert eval_example(9) == 54
      assert eval_example(10) == 7
      assert eval_example(11) == 9
      assert eval_example(12) == 1
      assert eval_example(13) == 0
      assert eval_example(14) == 0
      assert eval_example(15) == 1
    end
  end
end
