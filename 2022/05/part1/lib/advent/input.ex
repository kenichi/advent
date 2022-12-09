defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"
  @step_regex ~r/move (\d+) from (\d+) to (\d+)/

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    [stacks, steps] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))

    {parse_stacks(stacks), parse_steps(steps)}
  end

  defp parse_stacks(stacks) do
    count = stack_count(stacks)
    columns = Enum.map(stacks, &parse_stack(&1, count))
    map = for c <- 0..(count - 1), into: %{}, do: {c, []}

    columns
    |> Enum.reverse()
    |> then(fn [_stack_numbers | columns] -> columns end)
    |> Enum.reduce(map, &reduce_column/2)
  end

  defp stack_count(stacks) do
    stacks
    |> Enum.reverse()
    |> hd()
    |> String.split(" ", trim: true)
    |> Enum.reverse()
    |> hd()
    |> String.to_integer()
  end

  defp parse_stack(line, count) do
    s = String.codepoints(line)

    for c <- 0..(count - 1) do
      i = 1 + c * 4
      Enum.at(s, i)
    end
  end

  defp reduce_column(column, map) do
    column
    |> Enum.with_index()
    |> Enum.reduce(map, &reduce_crate/2)
  end

  defp reduce_crate({" ", _column}, map), do: map

  defp reduce_crate({crate, column}, map) do
    stack = Map.get(map, column)
    Map.put(map, column, [crate | stack])
  end

  defp parse_steps(steps), do: Enum.map(steps, &parse_step/1)

  defp parse_step(step) do
    [_match | nft] = Regex.run(@step_regex, step)

    nft
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
    |> decrement_stack_numbers()
  end

  defp decrement_stack_numbers({n, f, t}), do: {n, f - 1, t - 1}
end
