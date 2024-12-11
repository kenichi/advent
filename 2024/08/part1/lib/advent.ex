defmodule Advent do
  @moduledoc false

  defstruct antinodes: MapSet.new(), map: %{}, maxx: 0, maxy: 0

  @type antinodes :: MapSet.t()

  @type coord :: {integer(), integer()}

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
          |> antinodes_for(other)
          |> update_antinodes(advent)
        end)
      end)
    end)
  end

  @spec antinodes_for(coord(), coord()) :: [coord()]
  defp antinodes_for({ax, ay}, {bx, by}) do
    {dx, dy} = {bx - ax, by - ay}

    [{ax - dx, ay - dy}, {bx + dx, by + dy}]
  end

  @spec update_antinodes([coord()], t()) :: t()
  defp update_antinodes(antinodes, %__MODULE__{} = advent) do
    Enum.reduce(antinodes, advent, fn {ax, ay} = an, advent ->
      if ax < 0 or ax > advent.maxx or ay < 0 or ay > advent.maxy do
        advent
      else
        %Advent{advent | antinodes: MapSet.put(advent.antinodes, an)}
      end
    end)
  end

  @spec antinode_size(t()) :: integer()
  defp antinode_size(%__MODULE__{antinodes: antinodes}) do
    MapSet.size(antinodes)
  end
end
