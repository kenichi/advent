defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "count_x_mas/1", %{input: input} do
    assert count_x_mas(input) == 9
  end
end
