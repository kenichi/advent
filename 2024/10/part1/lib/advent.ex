defmodule Advent do
  @moduledoc false

  defstruct heads: [], map: %{}, maxx: -1, maxy: -1

  @type coord :: {integer(), integer()}

  @type head_nines :: {coord(), MapSet.t()}

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
    |> score_sum()
  end

  @doc """
  Determine trailhead scores from the map and sum.
  """
  @spec score_sum(t()) :: integer()
  def score_sum(advent) do
    advent.heads
    |> Enum.map(&score_trail({&1, MapSet.new()}, advent))
    |> Enum.sum()
  end

  @spec score_trail(head_nines(), t()) :: integer()
  defp score_trail({xy, nines}, %__MODULE__{map: map}) do
    {xy, nines}
    |> hike(map)
    |> MapSet.size()
  end

  @spec hike(head_nines(), topomap()) :: MapSet.t()
  defp hike({xy, nines}, map) do
    case possible_steps(xy, map) do
      [] ->
        nines

      possible ->
        Enum.reduce(possible, nines, fn pxy, nines ->
          if map[pxy] == 9 do
            MapSet.put(nines, pxy)
          else
            hike({pxy, nines}, map)
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
