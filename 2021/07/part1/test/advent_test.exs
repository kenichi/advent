defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  describe "Advent.eval/1" do
    test "example input" do
      observed =
        TestHelpers.parsed_example()
        |> Advent.eval()

      expected = 37

      assert observed == expected
    end
  end

  def positions(_), do: %{positions: TestHelpers.parsed_example()}

  describe "Advent.fuel_for/2" do
    setup [:positions]

    test "example pos 2", %{positions: ps} do
      assert Advent.fuel_for(2, ps) == 37
    end

    test "example pos 1", %{positions: ps} do
      assert Advent.fuel_for(1, ps) == 41
    end

    test "example pos 3", %{positions: ps} do
      assert Advent.fuel_for(3, ps) == 39
    end
    
    test "example pos 10", %{positions: ps} do
      assert Advent.fuel_for(10, ps) == 71
    end
  end
end
