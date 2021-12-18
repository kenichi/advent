defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    @tag timeout: :infinity
    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 2188189693529
    end
  end

  describe "Advent.repeat_insert/3" do
    setup [:parse_example]

    test "example input 1 time", %{example: [t, rs]} do
      t = Advent.count_pairs(t)
      assert Advent.repeat_insert(t, rs, 1) ==
        Advent.count_pairs('NCNBCHB')
    end

    test "example input 2 times", %{example: [t, rs]} do
      t = Advent.count_pairs(t)
      assert Advent.repeat_insert(t, rs, 2) ==
        Advent.count_pairs('NBCCNBBBCBHCB')
    end

    test "example input 3 times", %{example: [t, rs]} do
      t = Advent.count_pairs(t)
      assert Advent.repeat_insert(t, rs, 3) ==
        Advent.count_pairs('NBBBCNCCNBBNBNBBCHBHHBCHB')
    end

    test "example input 4 times", %{example: [t, rs]} do
      t = Advent.count_pairs(t)
      assert Advent.repeat_insert(t, rs, 4) ==
        Advent.count_pairs('NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB')
    end
  end
end
