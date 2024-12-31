defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @type plants :: %{Advent.coord() => String.t()}

  @type acc :: {plants(), integer(), integer()}

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.regions()
  def parse(input \\ read()) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.reduce({%{}, 0, 0}, &reduce_line/2)
    |> region_sets()
  end

  @spec reduce_line([String.t()], acc()) :: acc()
  defp reduce_line(line, {plants, x, y}) do
    {plants, _, _} =
      Enum.reduce(line, {plants, x, y}, fn p, {ps, x, y} ->
        {Map.put(ps, {x, y}, p), x + 1, y}
      end)

    {plants, 0, y + 1}
  end

  @spec region_sets(acc()) :: Advent.regions()
  defp region_sets({plants, _, _}) do
    {regions, _done} =
      Enum.reduce(plants, {%{}, MapSet.new()}, fn {{x, y}, p}, {regions, done} ->
        if MapSet.member?(done, {x, y}) do
          {regions, done}
        else
          region = build_region({x, y}, p, plants)
          done = MapSet.union(done, region)

          {Map.put(regions, p, [region | Map.get(regions, p, [])]), done}
        end
      end)

    regions
  end

  @spec build_region(Advent.coord(), String.t(), plants(), MapSet.t()) :: MapSet.t()
  defp build_region(xy, plant, plants, region \\ MapSet.new()) do
    region = MapSet.put(region, xy)

    xy
    |> Advent.neighbors()
    |> Enum.filter(&(not MapSet.member?(region, &1) and plants[&1] == plant))
    |> Enum.reduce(region, fn n, r -> build_region(n, plant, plants, r) end)
  end
end
