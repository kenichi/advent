ExUnit.start()

defmodule TestHelpers do
  @example """
  target area: x=20..30, y=-10..-5
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
