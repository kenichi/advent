defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  def parse_example(_), do: %{example: TestHelpers.parsed_example()}

  describe "Advent.eval/1" do
    setup [:parse_example]

    test "example input", %{example: ex} do
      assert Advent.eval(ex) == 1588
    end
  end

  describe "Advent.repeat_insert/3" do
    setup [:parse_example]

    test "example input 1 time", %{example: [t, rs]} do
      assert Advent.repeat_insert(t, rs, 1) == 'NCNBCHB'
    end

    test "example input 2 times", %{example: [t, rs]} do
      assert Advent.repeat_insert(t, rs, 2) == 'NBCCNBBBCBHCB'
    end

    test "example input 3 times", %{example: [t, rs]} do
      assert Advent.repeat_insert(t, rs, 3) == 'NBBBCNCCNBBNBNBBCHBHHBCHB'
    end

    test "example input 4 times", %{example: [t, rs]} do
      assert Advent.repeat_insert(t, rs, 4) ==
        'NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB'
    end
  end
end
