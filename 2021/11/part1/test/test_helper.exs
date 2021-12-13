ExUnit.start()

defmodule TestHelpers do
  @example """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  def example_input() do
    {:ok, pid} = StringIO.open(@example)
    pid
  end

  def parsed_example() do
    example_input()
    |> Advent.Input.read()
    |> Advent.Input.parse()
  end
end
