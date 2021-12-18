ExUnit.start()

defmodule TestHelpers do
  @example """
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
  """

  def example_input() do
    {:ok, pid} = StringIO.open(@example)
    pid
  end

  def parsed_example(input \\ example_input()) do
    input
    |> Advent.Input.read()
    |> Advent.Input.parse()
  end
end
