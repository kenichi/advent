ExUnit.start()

defmodule TestHelpers do
  @example_1 """
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
  """

  @example_2 """
  dc-end
  HN-start
  start-kj
  dc-start
  dc-HN
  LN-dc
  HN-end
  kj-sa
  kj-HN
  kj-dc
  """

  @example_3 """
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
  """

  def example_1(), do: @example_1
  def example_2(), do: @example_2
  def example_3(), do: @example_3

  def example_input(input \\ example_1()) do
    {:ok, pid} = StringIO.open(input)
    pid
  end

  def parsed_example(input \\ example_1()) do
    example_input(input)
    |> Advent.Input.read()
    |> Advent.Input.parse()
  end
end
