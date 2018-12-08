defmodule AdventTest do
  use ExUnit.Case

  @input %{
    "aA" => 0,
    "abBA" => 0,
    "abAB" => 4,
    "aabAAB" => 6,
    "dabAcCaCBAcCcaDA" => 10
  }

  test "read_input" do
    {:ok, dev} = StringIO.open("""
      foo
      """)
    assert Advent.read_input(dev) == "foo"
  end

  test "eval" do
    Enum.each @input, fn {line, count} ->
      assert Advent.eval(line) == count 
    end
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
