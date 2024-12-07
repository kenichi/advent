defmodule Advent do
  @moduledoc false

  defstruct direction: :n,
            guard: {nil, nil},
            maxx: 0,
            maxy: 0,
            obstacles: [],
            positions: MapSet.new()

  @type coord :: {integer(), integer()}

  @type direction :: :n | :e | :s | :w

  @type t :: %__MODULE__{
          direction: direction(),
          guard: coord(),
          maxx: integer(),
          maxy: integer(),
          obstacles: [coord()],
          positions: MapSet.t()
        }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> distinct_positions()
  end

  @doc """
  Count number of distinct positions guard travels to.
  """
  @spec distinct_positions(t()) :: integer()
  def distinct_positions(advent) do
    advent
    |> guard_step()
    |> Map.get(:positions)
    |> MapSet.size()
  end

  @spec guard_step(t()) :: t()
  defp guard_step(%Advent{} = advent) do
    possible_next = next_position(advent)

    cond do
      outside?(advent, possible_next) ->
        advent

      possible_next in advent.obstacles ->
        turn_and_step(advent)

      true ->
        advent
        |> update(possible_next)
        |> guard_step()
    end
  end

  @spec turn_and_step(t()) :: t()
  defp turn_and_step(advent) do
    advent
    |> turn_guard()
    |> guard_step()
  end

  @spec update(t(), coord()) :: t()
  defp update(advent, position) do
    %Advent{
      advent
      | guard: position,
        positions: MapSet.put(advent.positions, position)
    }
  end

  @spec next_position(t()) :: coord()
  defp next_position(%Advent{guard: {gx, gy}} = advent) do
    case advent.direction do
      :n -> {gx, gy - 1}
      :e -> {gx + 1, gy}
      :s -> {gx, gy + 1}
      :w -> {gx - 1, gy}
    end
  end

  @spec turn(direction()) :: direction()
  defp turn(:n), do: :e
  defp turn(:e), do: :s
  defp turn(:s), do: :w
  defp turn(:w), do: :n

  @spec turn_guard(t()) :: t()
  defp turn_guard(%Advent{direction: dir} = advent) do
    %Advent{advent | direction: turn(dir)}
  end

  @spec outside?(t(), coord()) :: boolean()
  defp outside?(%Advent{maxx: maxx, maxy: maxy}, {x, y}) do
    x < 0 or x > maxx or y < 0 or y > maxy
  end
end
