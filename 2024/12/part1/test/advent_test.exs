defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input_a """
  AAAA
  BBCD
  BBCC
  EEEC
  """

  @test_input_b """
  OOOOO
  OXOXO
  OOOOO
  OXOXO
  OOOOO
  """

  @test_input_c """
  RRRRIICCFF
  RRRRIICCCF
  VVRRRCCFFF
  VVRCCCJFFF
  VVVVCJJCFE
  VVIVCCJJEE
  VVIIICJJEE
  MIIIIIJJEE
  MIIISIJEEE
  MMMISSJEEE
  """

  describe "fence_cost/2 - A" do
    setup do: %{input: Advent.Input.parse(@test_input_a)}

    test "fence_cost/2", %{input: input} do
      assert fence_cost(input) == 140
    end
  end

  describe "fence_cost/2 - B" do
    setup do: %{input: Advent.Input.parse(@test_input_b)}

    test "fence_cost/2", %{input: input} do
      assert fence_cost(input) == 772
    end
  end

  describe "fence_cost/2 - C" do
    setup do: %{input: Advent.Input.parse(@test_input_c)}

    test "fence_cost/2", %{input: input} do
      assert fence_cost(input) == 1930
    end
  end
end
