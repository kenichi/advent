defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> full_sand_units()
  end

  def full_sand_units(blocks) do
    blocks = add_floor(blocks)
    maxy = max_y(blocks)

    drop_sand(blocks, MapSet.new(), maxy)
  end

  defp max_y(blocks) do
    blocks
    |> Enum.map(&elem(&1, 1))
    |> Enum.max()
  end

  @drops_from {500, 0}

  defp drop_sand(blocks, sands, maxy) do
    {blocks, sands} = drop_until_stopped(@drops_from, blocks, sands, maxy)

    if full?(blocks), do: MapSet.size(sands) + 1, else: drop_sand(blocks, sands, maxy)
  end

  @spec drop_until_stopped({integer, integer}, MapSet.t(), MapSet.t(), integer) ::
          {MapSet.t(), MapSet.t()}
  defp drop_until_stopped({sx, sy} = sand, blocks, sands, maxy) do
    if sy > maxy do
      raise "@x_tolerance too low"
    else
      if MapSet.member?(blocks, {sx, sy + 1}) do
        if MapSet.member?(blocks, {sx - 1, sy + 1}) do
          if MapSet.member?(blocks, {sx + 1, sy + 1}) do
            {
              MapSet.put(blocks, sand),
              MapSet.put(sands, sand)
            }
          else
            drop_until_stopped({sx + 1, sy + 1}, blocks, sands, maxy)
          end
        else
          drop_until_stopped({sx - 1, sy + 1}, blocks, sands, maxy)
        end
      else
        drop_until_stopped({sx, sy + 1}, blocks, sands, maxy)
      end
    end
  end

  defp min_max_x(blocks) do
    blocks
    |> Enum.map(&elem(&1, 0))
    |> Enum.min_max()
  end

  @x_tolerance 1000

  defp add_floor(blocks) do
    {minx, maxx} = min_max_x(blocks)
    floor_y = max_y(blocks) + 2
    floor = for x <- (minx - @x_tolerance)..(maxx + @x_tolerance), do: {x, floor_y}

    Enum.reduce(floor, blocks, &MapSet.put(&2, &1))
  end

  @full [{499, 1}, {500, 1}, {501, 1}]

  defp full?(blocks), do: Enum.all?(@full, &MapSet.member?(blocks, &1))
end
