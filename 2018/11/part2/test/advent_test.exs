defmodule AdventTest do
  use ExUnit.Case

  test "cell_power" do
    assert Advent.cell_power(  3,   5,  8) == 4 
    assert Advent.cell_power(122,  79, 57) == -5
    assert Advent.cell_power(217, 196, 39) == 0
    assert Advent.cell_power(101, 153, 71) == 4
  end

  test "square_power" do
    assert Advent.build_grid(18)
           |> Advent.build_summed_area_table
           |> Advent.square_power(33, 45) == 29

    assert Advent.build_grid(42)
           |> Advent.build_summed_area_table
           |> Advent.square_power(21, 61) == 30
  end

  test "eval" do
    assert Advent.eval(18) == {{90, 269, 16}, 113}
    assert Advent.eval(42) == {{232, 251, 12}, 119}
  end

end
