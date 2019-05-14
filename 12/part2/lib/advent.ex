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

  def process("initial state: " <> state, {_, rules}) do
    state =
      String.codepoints(state)
      |> Enum.with_index
      |> Enum.filter(&match?({"#",_}, &1))
      |> Enum.reduce(MapSet.new, fn {_, i}, set -> MapSet.put(set, i) end)

    {state, rules}
  end
  def process("", sr), do: sr
  def process(rule, {state, rules}), do: {state, parse_rule(rule, rules)}


  def parse_rule(<<pattern::binary-size(5)>> <> " => #", rules) do
    MapSet.put(rules, String.codepoints(pattern))
  end
  def parse_rule(_, rules), do: rules

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

  # stolen from jeg2's solution
  #
  def find_stability(srs) do
    Enum.reduce_while(
      1..50_000_000_000,
      {srs, 0, [ ]},
      fn i, {srs, prev_count, differences} ->

        next_srs = generate(srs)
        next_count = elem(next_srs, 0) |> Enum.sum
        difference = next_count - prev_count
        new_differences = [difference | differences]

        if length(new_differences) < 10 do
          {:cont, {next_srs, next_count, new_differences}}

        else

          # IO.inspect(new_differences)
          # IO.inspect(next_count)
          #
          # deltas between sum counts of each generation converge, so looking
          # at the last 10, we wait until those are all the same. once that
          # hits, we take the diff between total and current iterations,
          # multiplied by the delta, added with the latest sum
          #
          case Enum.uniq(new_differences) do
            [n] ->
              {:halt, (50_000_000_000 - i) * n + next_count}

            _not_stable ->
              {:cont, {next_srs, next_count, Enum.take(new_differences, 10)}}
          end

        end
      end
    )
  end

  def eval(file \\ "input/input.txt") do
    file_stream(file)
    |> read_input
    |> find_stability
  end

end
