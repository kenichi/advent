defmodule Advent do
  @moduledoc """
  First, the energy level of each octopus increases by 1.

  Then, any octopus with an energy level greater than 9 flashes. This increases
  the energy level of all adjacent octopuses by 1, including octopuses that are
  diagonally adjacent. If this causes an octopus to have an energy level
  greater than 9, it also flashes. This process continues as long as new
  octopuses keep having their energy level increased beyond 9. (An octopus can
  only flash at most once per step.)

  Finally, any octopus that flashed during this step has its energy level set to
  0, as it used all of its energy to flash.
  """

  def eval(map \\ Advent.Input.parse(), steps \\ 100) do
    Enum.reduce(1..steps, {map, 0}, &map_step/2)
    |> elem(1)
  end

  def map_step(_step, {map, count}) do
    points = Map.keys(map)

    # increase energy
    map = Enum.reduce(points, map, &increment/2)

    # flash
    map = flash(map)

    # reset to zero
    Enum.reduce(points, {map, count}, fn p, {m, c} ->
      if m[p] == "*", do: {Map.put(m, p, 0), c + 1}, else: {m, c}
    end)
  end

  def increment(p, map) do
    case map[p] do
      "*" -> map
      e -> Map.put(map, p, e + 1)
    end
  end

  def flash(map) do
    map
    |> flashing_points()
    |> flash_cycle(map)
  end

  def flashing_points(map) do
    Enum.filter(map, fn
      {_, "*"} -> false
      {_, e} -> e > 9
    end)
    |> Enum.map(&elem(&1, 0))
  end

  def flash_cycle([], map), do: map
  def flash_cycle(points, map) do
    map = Enum.reduce(points, map, &flash_point/2)

    map
    |> flashing_points()
    |> flash_cycle(map)
  end

  def flash_point(p, map) do
    surroundings(p)
    |> Enum.reduce(map, &increment/2)
    |> then(fn map -> Map.put(map, p, "*") end)
  end

  def surroundings({x, y}) do
    [
      {x + 1, y},     # e
      {x + 1, y + 1}, # se
      {x, y + 1},     # s
      {x - 1, y + 1}, # sw
      {x - 1, y},     # w
      {x - 1, y - 1}, # nw
      {x, y - 1},     # n
      {x + 1, y - 1}  # ne
    ]
    |> Enum.filter(fn {x, y} ->
      (x >= 0 and x < 10) and (y >= 0 and y < 10)
    end)
  end
end
