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
      K)YOU
      I)SAN
      """)

    Advent.read_input(dev)
  end

  test "get to santa" do
    assert Advent.eval(test_map()) == 4
  end
end
