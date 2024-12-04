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

  test "count_xmas/1", %{input: input} do
    assert count_xmas(input) == 18
  end
end
