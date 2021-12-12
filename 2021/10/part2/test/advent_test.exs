defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 288957
    end
  end
end
