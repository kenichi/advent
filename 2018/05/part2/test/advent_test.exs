defmodule AdventTest do
  use ExUnit.Case

  @input "dabAcCaCBAcCcaDA"

  test "read_input" do
    {:ok, dev} = StringIO.open("""
      foo
      """)
    assert Advent.read_input(dev) == "foo"
  end

  test "eval" do
    assert Advent.eval(@input) == 4
  end

  test "alchemy_reduce" do
    assert Advent.alchemy_reduce(@input) == 10
  end

  test "letter_set" do
    assert Advent.letter_set(@input) == MapSet.new(~w(a b c d))
  end

  test "remove_letter" do
    assert Advent.remove_letter(@input, "a") == "dbcCCBcCcD"
    assert Advent.remove_letter(@input, "b") == "daAcCaCAcCcaDA"
    assert Advent.remove_letter(@input, "c") == "dabAaBAaDA"
    assert Advent.remove_letter(@input, "d") == "abAcCaCBAcCcaA"
  end

  test "check_couplet" do
    assert Advent.check_couplet("a", "A")
    assert Advent.check_couplet("A", "a")
    refute Advent.check_couplet("A", "A")
    refute Advent.check_couplet("a", "a")
    refute Advent.check_couplet("a", "b")
    refute Advent.check_couplet("A", "B")
    refute Advent.check_couplet("a", "B")
    refute Advent.check_couplet("A", "b")
  end

end
