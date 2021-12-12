ExUnit.start()

defmodule TestHelpers do
  @example """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
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
