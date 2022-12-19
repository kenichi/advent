defmodule AdventTest do
  use ExUnit.Case

  @test_input_1 """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  @test_input_2 """
  R 5
  U 8
  L 8
  D 3
  R 17
  D 10
  L 25
  U 20
  """

  describe "Advent" do
    test "tail_positions/1 - 1" do
      assert @test_input_1
             |> Advent.Input.parse()
             |> Advent.tail_positions() == 1
    end

    test "tail_positions/1 - 2" do
      assert @test_input_2
             |> Advent.Input.parse()
             |> Advent.tail_positions() == 36
    end
  end
end
