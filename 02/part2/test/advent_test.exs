defmodule AdventTest do
  use ExUnit.Case

  @input """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
  """

  test "read_input" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) == [
      "abcde",
      "fghij",
      "klmno",
      "pqrst",
      "fguij",
      "axcye",
      "wvxyz"
    ]
  end

  test "common" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev) |> Advent.common == "fgij"
  end

  test "find_match" do
    {:ok, dev} = StringIO.open(@input)
    list = Advent.read_input(dev) 
    assert Advent.find_match(list, "abcde") == nil
    assert Advent.find_match(list, "fghij") == "fguij"
    assert Advent.find_match(list, "klmno") == nil
    assert Advent.find_match(list, "pqrst") == nil
    assert Advent.find_match(list, "fguij") == "fghij"
    assert Advent.find_match(list, "axcye") == nil
    assert Advent.find_match(list, "wvxyz") == nil
  end

  test "count_eqs" do
    assert Advent.count_eqs("abcde", "abzdf") == 3
    assert Advent.count_eqs("abcde", "abcdf") == 4
    assert Advent.count_eqs("abcde", "abcde") == 5
    assert Advent.count_eqs("abcde", "edcba") == 1
  end

end
