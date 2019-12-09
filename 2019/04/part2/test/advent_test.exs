defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "six_digits?" do
    refute Advent.six_digits?(99999)
    assert Advent.six_digits?(100_000)
    assert Advent.six_digits?(999_999)
    refute Advent.six_digits?(1_000_000)
  end

  test "in_range?" do
    refute Advent.in_range?(231_831)
    assert Advent.in_range?(231_832)
    assert Advent.in_range?(767_346)
    refute Advent.in_range?(767_347)
  end

  test "adjacent_digits?" do
    refute Advent.adjacent_digits?(123_456)
    assert Advent.adjacent_digits?(122_345)
    assert Advent.adjacent_digits?(123_455)
    refute Advent.adjacent_digits?(767_676)

    assert Advent.adjacent_digits?(112_233)
    refute Advent.adjacent_digits?(123_444)
    assert Advent.adjacent_digits?(111_122)
  end

  test "never_decreases?" do
    refute Advent.never_decreases?(123_454)
    assert Advent.never_decreases?(122_345)
    assert Advent.never_decreases?(123_455)
    refute Advent.never_decreases?(767_676)
  end
end
