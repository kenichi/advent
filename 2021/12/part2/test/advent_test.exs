defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_examples(_) do
    %{
      example_1: TestHelpers.parsed_example(),
      example_2: TestHelpers.parsed_example(TestHelpers.example_2()),
      example_3: TestHelpers.parsed_example(TestHelpers.example_3()),
    }
  end

  describe "Advent.eval/1" do
    setup [:parse_examples]

    test "example input 1", %{example_1: ex} do
      assert Advent.eval(ex) == 36
    end

    test "example input 2", %{example_2: ex} do
      assert Advent.eval(ex) == 103
    end

    test "example input 3", %{example_3: ex} do
      assert Advent.eval(ex) == 3509
    end
  end
end
