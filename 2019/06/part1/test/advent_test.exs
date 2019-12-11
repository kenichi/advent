defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def test_map() do
    {:ok, dev} =
      StringIO.open("""
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
      """)

    Advent.read_input(dev)
  end

  test "example from D" do
    assert Advent.path_to_com("D", test_map()) == 3
  end

  test "example from L" do
    assert Advent.path_to_com("L", test_map()) == 7
  end

  test "example from COM" do
    assert Advent.path_to_com("COM", test_map()) == 0
  end

  test "example total orbits" do
    assert Advent.eval(test_map()) == 42
  end
end
