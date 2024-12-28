defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  2333133121414131402
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "fs_checksum/1", %{input: input} do
    assert fs_checksum(input) == 1928
  end
end
