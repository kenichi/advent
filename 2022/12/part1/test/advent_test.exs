defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  """

  describe "Advent.Input" do
    test "parse/1" do
      assert {map, start, finish} = Advent.Input.parse(@test_input)
      assert is_map(map)
      assert is_tuple(start)
      assert is_tuple(finish)

      # start/finish heights
      assert Map.get(map, {0, 0}) == 97
      assert Map.get(map, {5, 2}) == 122

      # spot checks
      assert Map.get(map, {0, 2}) == 97
      assert Map.get(map, {7, 2}) == 107
      assert Map.get(map, {3, 3}) == 116
      assert Map.get(map, {7, 4}) == 105

      assert start == {0, 0}
      assert finish == {5, 2}
    end
  end

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "ascent_steps/1", %{input: input} do
      assert Advent.ascent_steps(input) == 31
    end
  end
end
