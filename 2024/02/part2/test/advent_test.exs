defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "safe_reports_count/1", %{input: input} do
    assert safe_reports_count(input) == 4
  end
end
