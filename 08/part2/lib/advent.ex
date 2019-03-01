defmodule Advent do

  defmodule Input do
    defstruct [:data, cursor: 0]

    def counts(%Input{} = input) do
      cc = Enum.at(input.data, input.cursor)
      mdc = Enum.at(input.data, input.cursor + 1)
      input = %Input{ input | cursor: input.cursor + 2 }

      {input, cc, mdc}
    end

    def metadata(%Input{} = input, count) do
      md = for i <- input.cursor..(input.cursor + (count - 1)) do
        Enum.at(input.data, i)
      end
      input = %Input{ input | cursor: input.cursor + count }

      {input, md}
    end

  end

  defmodule Node do
    defstruct [children: [], metadata: []]
  end

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split(" ", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def build_node({%Input{} = input, cc, mdc}) do
    if cc > 0 do

      {input, children} = Enum.reduce(1..cc, {input, []}, fn _, {i, cs} ->
        {i, c} = parse_header(i)
        {i, cs ++ [c]}
      end)

      if mdc > 0 do
        {input, metadata} = Input.metadata(input, mdc)
        {input, %Node{ children: children, metadata: metadata }}

      else
        {input, %Node{ children: children }}

      end
    else
      if mdc > 0 do
        {input, metadata} = Input.metadata(input, mdc)
        {input, %Node{ metadata: metadata }}

      else
        raise "do we get here?"
        {input, %Node{}}

      end

    end
  end

  def parse_header(input) do
    Input.counts(input)
    |> build_node
  end

  def node_value(node) do
    if length(node.children) == 0 do
      Enum.reduce(node.metadata, 0, fn n, s -> s + n end)

    else
      Enum.map(node.metadata, fn i -> Enum.at(node.children, (i - 1)) end)
      |> Enum.reduce(0, fn
        nil, s -> s
        n, s -> node_value(n) + s
      end)

    end
  end

  def eval(input \\ read_input()) do
    {_, root} = parse_header(%Input{ data: input })
    node_value(root)
  end

end
