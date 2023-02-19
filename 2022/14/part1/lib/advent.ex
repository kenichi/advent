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
    drop_sand(blocks, max_y(blocks))
  end

  defp max_y(blocks) do
    blocks
    |> Enum.map(&elem(&1, 1))
    |> Enum.max()
  end

  @drops_from {500, 0}

  defp drop_sand(blocks, maxy, units \\ 0) do
    case drop_until_stopped(@drops_from, blocks, maxy) do
      :infinity ->
        units

      blocks ->
        drop_sand(blocks, maxy, units + 1)
    end
  end

  @spec drop_until_stopped({integer, integer}, MapSet.t(), integer) :: MapSet.t() | :infinity
  defp drop_until_stopped({sx, sy} = sand, blocks, maxy) do
    if sy + 1 > maxy do
      :infinity
    else
      if MapSet.member?(blocks, {sx, sy + 1}) do
        if MapSet.member?(blocks, {sx - 1, sy + 1}) do
          if MapSet.member?(blocks, {sx + 1, sy + 1}) do
            MapSet.put(blocks, sand)
          else
            drop_until_stopped({sx + 1, sy + 1}, blocks, maxy)
          end
        else
          drop_until_stopped({sx - 1, sy + 1}, blocks, maxy)
        end
      else
        drop_until_stopped({sx, sy + 1}, blocks, maxy)
      end
    end
  end
end
