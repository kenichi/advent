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

end
