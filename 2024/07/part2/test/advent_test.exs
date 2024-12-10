defmodule AdventTest do
  use ExUnit.Case

  import Advent

  @test_input """
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  """

  setup do: %{input: Advent.Input.parse(@test_input)}

  test "calibration_result/1", %{input: input} do
    assert calibration_result(input) == 11387
  end

  test "eval_numbers/1" do
    assert eval_numbers([{10, :+}, {19, :halt}]) == 29
    assert eval_numbers([{10, :*}, {19, :halt}]) == 190
    assert eval_numbers([{10, :||}, {19, :halt}]) == 1019
  end

  test "permutations_of/2" do
    expected =
      MapSet.new([
        [1, 1, 1, 1],
        [1, 1, 1, 2],
        [1, 1, 2, 1],
        [1, 1, 2, 2],
        [1, 2, 1, 1],
        [1, 2, 1, 2],
        [1, 2, 2, 1],
        [1, 2, 2, 2],
        [2, 1, 1, 1],
        [2, 1, 1, 2],
        [2, 1, 2, 1],
        [2, 1, 2, 2],
        [2, 2, 1, 1],
        [2, 2, 1, 2],
        [2, 2, 2, 1],
        [2, 2, 2, 2]
      ])

    observed = permutations_of([1, 2], 4) |> MapSet.new()
    assert MapSet.equal?(expected, observed)
  end

  test "flatten/1" do
    assert flatten([[1, 2], [3, 4]]) == [[3, 4], [1, 2]]
    assert flatten([[[1, 2]], [[3, 4]]]) == [[3, 4], [1, 2]]
  end

  test "permutations/1" do
    assert permutations([1, 2]) == [
             [{1, :||}, {2, :halt}],
             [{1, :*}, {2, :halt}],
             [{1, :+}, {2, :halt}]
           ]
  end
end
