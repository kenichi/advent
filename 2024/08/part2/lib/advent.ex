defmodule Advent do
  @moduledoc false

  defstruct antinodes: MapSet.new(), map: %{}, maxx: 0, maxy: 0

  @type antinodes :: MapSet.t()

  @type coord :: {integer(), integer()}

  @type direction :: :+ | :-

  @type frequency :: atom()

  @type t :: %__MODULE__{
          map: %{frequency() => [coord()]},
          maxx: non_neg_integer(),
          maxy: non_neg_integer()
        }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_antinodes()
  end

  @doc """
  Count all unique antinode locations.
  """
  @spec count_antinodes(t()) :: integer()
  def count_antinodes(advent) do
    advent
    |> generate_antinodes()
    |> antinode_size()
  end

  @spec generate_antinodes(t()) :: t()
  def generate_antinodes(advent) do
    Enum.reduce(advent.map, advent, fn {_frequency, coords}, advent ->
      Enum.reduce(coords, advent, fn coord, advent ->
        Enum.reduce(coords -- [coord], advent, fn other, advent ->
          coord
          |> antinodes_for(other, advent)
          |> update_antinodes(advent)
        end)
      end)
    end)
  end

  @spec antinodes_for(coord(), coord(), t()) :: [coord()]
  defp antinodes_for({ax, ay}, {bx, by}, %__MODULE__{maxx: maxx, maxy: maxy}) do
    {dx, dy} = {bx - ax, by - ay}

    [{ax, ay}, {bx, by}]
    |> step({ax, ay}, {dx, dy}, {maxx, maxy}, :-)
    |> step({ax, ay}, {dx, dy}, {maxx, maxy}, :+)
  end

  @spec step([coord()], coord(), coord(), coord(), direction()) :: [coord()]
  defp step(steps, {x, y}, {dx, dy}, {maxx, maxy}, direction) do
    {nx, ny} =
      {
        apply(Kernel, direction, [x, dx]),
        apply(Kernel, direction, [y, dy])
      }

    if nx < 0 or nx > maxx or ny < 0 or ny > maxy do
      steps
    else
      step([{nx, ny} | steps], {nx, ny}, {dx, dy}, {maxx, maxy}, direction)
    end
  end

  @spec update_antinodes([coord()], t()) :: t()
  defp update_antinodes(antinodes, %__MODULE__{} = advent) do
    Enum.reduce(antinodes, advent, fn an, advent ->
      %Advent{advent | antinodes: MapSet.put(advent.antinodes, an)}
    end)
  end

  @spec antinode_size(t()) :: integer()
  defp antinode_size(%__MODULE__{antinodes: antinodes}) do
    MapSet.size(antinodes)
  end
end
