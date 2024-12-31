defmodule Advent do
  @moduledoc false

  @type coord :: {integer(), integer()}

  @type regions :: %{String.t() => [MapSet.t()]}

  @neighbors [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  ]

  @spec neighbors(coord()) :: [coord()]
  def neighbors({x, y}), do: Enum.map(@neighbors, fn {dx, dy} -> {x + dx, y + dy} end)

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> fence_cost()
  end

  @doc """
  """
  @spec fence_cost(regions()) :: integer()
  def fence_cost(regions) do
    Enum.reduce(regions, 0, fn r, t -> region_cost(r) + t end)
  end

  @spec region_cost({String.t(), [MapSet.t()]}) :: integer()
  defp region_cost({_plant, regions}) do
    regions
    |> Enum.map(&(area(&1) * perimeter(&1)))
    |> Enum.sum()
  end

  @spec area(MapSet.t()) :: integer()
  defp area(coords), do: MapSet.size(coords)

  @spec perimeter(MapSet.t()) :: integer()
  defp perimeter(region) do
    Enum.reduce(region, 0, fn {x, y}, sides ->
      s =
        {x, y}
        |> neighbors()
        |> Enum.reduce(4, fn n, p ->
          if MapSet.member?(region, n) do
            p - 1
          else
            p
          end
        end)

      sides + s
    end)
  end
end
