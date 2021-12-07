defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 168

      assert observed == expected
    end
  end

  def positions(_), do: %{positions: TestHelpers.parsed_example()}

  describe "Advent.fuel_for/2" do
    setup [:positions]

    test "example pos 2", %{positions: ps} do
      assert Advent.fuel_for(2, ps) == 206
    end

    test "example pos 5", %{positions: ps} do
      assert Advent.fuel_for(5, ps) == 168
    end
  end
end
