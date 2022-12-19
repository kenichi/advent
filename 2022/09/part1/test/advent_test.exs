defmodule AdventTest do
  use ExUnit.Case

  @test_input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  describe "Advent" do
    setup _, do: %{input: Advent.Input.parse(@test_input)}

    test "tail_positions/1", %{input: input} do
      assert Advent.tail_positions(input) == 13
    end
  end
end
