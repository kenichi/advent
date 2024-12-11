defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  ............
  ........0...
  .....0......
  .......0....
  ....0.......
  ......A.....
  ............
  ............
  ........A...
  .........A..
  ............
  ............
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "count_antinodes/1", %{input: input} do
    assert count_antinodes(input) == 14
  end

  test "generate_antinodes/1" do
    expected = MapSet.new([{3, 1}, {6, 7}])

    assert %Advent{map: %{a: [{4, 3}, {5, 5}]}, maxx: 9, maxy: 9}
           |> generate_antinodes()
           |> Map.fetch!(:antinodes)
           |> MapSet.equal?(expected)
  end
end