defmodule Advent do
  @moduledoc false

  defstruct head: {0, 0}, tail: {0, 0}, positions: MapSet.new()

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> tail_positions()
  end

  def tail_positions(input) do
    state =
      Enum.reduce(input, %__MODULE__{}, fn dir, state ->
        {d, n} = parse_dir(dir)

        move_head_times(state, d, n)
      end)

    MapSet.size(state.positions)
  end

  defp parse_dir(dir) do
    [d, n] = String.split(dir, " ")
    n = String.to_integer(n)
    {d, n}
  end

  defp save_position(%__MODULE__{tail: t, positions: ps} = s),
    do: %__MODULE__{s | positions: MapSet.put(ps, t)}

  defp move_head_times(state, _dir, 0), do: state

  defp move_head_times(state, dir, n) do
    state
    |> move_head(dir)
    |> follow_unless_touching()
    |> save_position()
    |> move_head_times(dir, n - 1)
  end

  defp move_head(%__MODULE__{head: {hx, hy}, tail: t, positions: ps}, "U"),
    do: %__MODULE__{head: {hx, hy + 1}, tail: t, positions: ps}

  defp move_head(%__MODULE__{head: {hx, hy}, tail: t, positions: ps}, "D"),
    do: %__MODULE__{head: {hx, hy - 1}, tail: t, positions: ps}

  defp move_head(%__MODULE__{head: {hx, hy}, tail: t, positions: ps}, "L"),
    do: %__MODULE__{head: {hx - 1, hy}, tail: t, positions: ps}

  defp move_head(%__MODULE__{head: {hx, hy}, tail: t, positions: ps}, "R"),
    do: %__MODULE__{head: {hx + 1, hy}, tail: t, positions: ps}

  defp follow_unless_touching(state),
    do: if(touching?(state), do: state, else: tail_follow(state))

  defp touching?(%__MODULE__{head: {hx, hy}, tail: {tx, ty}}),
    do: abs(hx - tx) < 2 && abs(hy - ty) < 2

  defp tail_follow(%__MODULE__{head: {hx, hy}, tail: {tx, ty}} = s) do
    tx =
      cond do
        hx > tx -> tx + 1
        hx < tx -> tx - 1
        true -> tx
      end

    ty =
      cond do
        hy > ty -> ty + 1
        hy < ty -> ty - 1
        true -> ty
      end

    %__MODULE__{s | tail: {tx, ty}}
  end
end
