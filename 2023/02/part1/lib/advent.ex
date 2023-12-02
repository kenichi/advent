defmodule Advent do
  @moduledoc false

  @bag %{
    red: 12,
    green: 13,
    blue: 14
  }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> possible_games_sum()
  end

  @doc """
  Find the IDs of all possible games and sum.
  """
  @spec possible_games_sum([String.t()], map()) :: integer()
  def possible_games_sum(list, bag \\ @bag) do
    list
    |> Enum.map(&parse_game/1)
    |> Enum.filter(&possible_game?(&1, bag))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp parse_game(str) do
    {id, rest} = parse_game_id(str)

    sets =
      rest
      |> String.split(";", trim: true)
      |> Enum.map(&parse_set/1)

    {id, sets}
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

  defp possible?(sets, bag) do
    Enum.all?(sets, fn set ->
      Enum.all?(set, fn {color, n} ->
        bag[color] >= n
      end)
    end)
  end

  defp possible_game?({_id, sets}, bag), do: possible?(sets, bag)
end
