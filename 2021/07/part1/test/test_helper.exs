ExUnit.start()

defmodule TestHelpers do
  @example """
  16,1,2,0,4,2,7,1,2,14
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
