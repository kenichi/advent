defmodule Advent do

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim/1)
  end

  def read_input(stream) do
    stream
    |> Enum.reduce({nil, MapSet.new}, &process/2)
  end

  def process(<<"initial state: ", state::binary>>, {_, rules}) do
    state =
      String.codepoints(state)
      |> Enum.with_index
      |> Enum.filter(&match?({"#",_}, &1))
      |> Enum.reduce(MapSet.new, fn {_, i}, set -> MapSet.put(set, i) end)

    {state, rules}
  end
  def process("", sr), do: sr
  def process(rule, {state, rules}), do: {state, parse_rule(rule, rules)}

  def parse_rule(rule, rules) do
    cond do
      String.ends_with?(rule, "#") ->
        MapSet.put(rules, String.codepoints(rule) |> Enum.slice(0..4))
      true ->
        rules
    end
  end

  def generate({state, rules}) do
    {left, right} = Enum.min_max(state)

    state =
      (left - 4)..(right + 4)
      |> Enum.chunk_every(5, 1, :discard)
      |> Enum.filter(&(MapSet.member?(rules, build_pots(&1, state))))
      |> Enum.map(&(Enum.at(&1, 2)))
      |> MapSet.new

    {state, rules}
  end

  def build_pots(indices, state) do
    Enum.map(indices, &(if MapSet.member?(state, &1), do: "#", else: "."))
  end

  def eval(file \\ "input/input.txt", gens \\ 20) do
    Enum.reduce(1..gens, file_stream(file) |> read_input, fn _, srs -> generate(srs) end)
    |> elem(0)
    |> Enum.sum
  end

end
