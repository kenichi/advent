defmodule Advent do
  @moduledoc false

  defstruct heads: [], map: %{}, maxx: -1, maxy: -1

  @type coord :: {integer(), integer()}

  @type head_trails :: {coord(), integer()}

  @type height :: integer()

  @type topomap :: %{coord() => height()}

  @type t :: %__MODULE__{
          heads: [coord()],
          map: topomap(),
          maxx: integer(),
          maxy: integer()
        }

  @directions [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  ]

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> ratings_sum()
  end

  @doc """
  Determine trailhead scores from the map and sum.
  """
  @spec ratings_sum(t()) :: integer()
  def ratings_sum(advent) do
    advent.heads
    |> Enum.map(&hike({&1, 0}, advent.map))
    |> Enum.sum()
  end

  @spec hike(head_trails(), topomap()) :: integer()
  defp hike({xy, trails}, map) do
    case possible_steps(xy, map) do
      [] ->
        trails

      possible ->
        Enum.reduce(possible, trails, fn pxy, trails ->
          if map[pxy] == 9 do
            trails + 1
          else
            hike({pxy, trails}, map)
          end
        end)
    end
  end

  @spec possible_steps(coord(), topomap()) :: [coord()]
  defp possible_steps({x, y}, map) do
    current = map[{x, y}]

    Enum.reduce(@directions, [], fn {dx, dy}, steps ->
      step = {x + dx, y + dy}

      if map[step] && map[step] - current == 1 do
        [step | steps]
      else
        steps
      end
    end)
  end
end
