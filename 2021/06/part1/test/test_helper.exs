ExUnit.start()

defmodule TestHelpers do
  @example """
  3,4,3,1,2
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
