defmodule AdventTest do
  use ExUnit.Case

  @input """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
  """

  test "read_input" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) == [
      "abcdef",
      "bababc",
      "abbcde",
      "abcccd",
      "aabcdd",
      "abcdee",
      "ababab"
    ]
  end

  test "checksum" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) |> Advent.checksum == 12
  end

  test "count" do
    m = %{97 => 2, 98 => 3, 99 => 1, 100 => 3}
    assert Advent.count(m, 3) == 2
    assert Advent.count(m, 2) == 1
    assert Advent.count(m, 1) == 1
    assert Advent.count(m, 4) == 0
  end

  test "parse" do
    assert Advent.parse("abcdef") ==
      %{97 => 1, 98 => 1, 99 => 1, 100 => 1, 101 => 1, 102 => 1}
    assert Advent.parse("bababc") ==
      %{97 => 2, 98 => 3, 99 => 1}
    assert Advent.parse("abbcde") ==
      %{97 => 1, 98 => 2, 99 => 1, 100 => 1, 101 => 1}
  end

  describe "add_char" do

    test "add_char creates new key with value 1" do
      assert Advent.add_char(%{}, 'a') == %{'a' => 1}
    end

    test "add_char adds 2 to value of existing key" do
      assert Advent.add_char(%{'a' => 1}, 'a') == %{'a' => 2}
    end

  end

end
