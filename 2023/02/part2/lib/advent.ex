defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> powers_sum()
  end

  @doc """
  Find the power of each minimal game set and sum.
  """
  @spec powers_sum([String.t()]) :: integer()
  def powers_sum(list) do
    list
    |> Enum.map(&parse_minimal_power/1)
    |> Enum.sum()
  end

  defp parse_minimal_power(game) do
    game
    |> parse_game()
    |> minimal_set()
    |> power()
  end

  defp parse_game(str) do
    {_id, rest} = parse_game_id(str)

    sets =
      rest
      |> String.split(";", trim: true)
      |> Enum.map(&parse_set/1)

    sets
  end

  defp parse_game_id(str) do
    [prefix, id_str] = Regex.run(~r/^Game (\d+): /, str)
    {String.to_integer(id_str), String.trim_leading(str, prefix)}
  end

  defp parse_set(set_str) do
    set_str
    |> String.split(",", trim: true)
    |> Enum.reduce(%{}, &reduce_cubes/2)
  end

  defp reduce_cubes(cubes, set) do
    case Regex.run(~r/(\d+) (\w+)/, String.trim(cubes)) do
      [_, n, color] ->
        Map.put(set, String.to_existing_atom(color), String.to_integer(n))

      other ->
        raise ArgumentError, "what: #{inspect(other)}"
    end
  end

  defp minimal_set(sets),
    do: Enum.reduce(sets, %{red: 0, green: 0, blue: 0}, &reduce_set/2)

  defp reduce_set(set, min) do
    Enum.reduce(set, min, fn {color, n}, m ->
      if m[color] < n, do: Map.put(m, color, n), else: m
    end)
  end

  defp power(set) do
    set[:red] * set[:green] * set[:blue]
  end
end
