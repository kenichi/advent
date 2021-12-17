ExUnit.start()

defmodule TestHelpers do
  @example """
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
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
