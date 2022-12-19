defmodule Advent do
  @moduledoc false

  defstruct a: {0, 0},
            b: {0, 0},
            c: {0, 0},
            d: {0, 0},
            e: {0, 0},
            f: {0, 0},
            g: {0, 0},
            h: {0, 0},
            i: {0, 0},
            j: {0, 0},
            positions: MapSet.new()

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

  defp save_position(%__MODULE__{j: j, positions: ps} = s),
    do: %__MODULE__{s | positions: MapSet.put(ps, j)}

  defp move_head_times(state, _dir, 0), do: state

  defp move_head_times(state, dir, n) do
    state
    |> move_head(dir)
    |> follow_unless_touching()
    |> save_position()
    |> move_head_times(dir, n - 1)
  end

  defp move_head(%__MODULE__{a: {ax, ay}} = s, "U"), do: %__MODULE__{s | a: {ax, ay + 1}}
  defp move_head(%__MODULE__{a: {ax, ay}} = s, "D"), do: %__MODULE__{s | a: {ax, ay - 1}}
  defp move_head(%__MODULE__{a: {ax, ay}} = s, "L"), do: %__MODULE__{s | a: {ax - 1, ay}}
  defp move_head(%__MODULE__{a: {ax, ay}} = s, "R"), do: %__MODULE__{s | a: {ax + 1, ay}}

  @knots [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j]

  defp follow_unless_touching(%__MODULE__{} = state) do
    @knots
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(state, fn [h, t], s ->
      if touching?(Map.get(s, h), Map.get(s, t)), do: s, else: follow(s, h, t)
    end)
  end

  defp touching?({ax, ay}, {bx, by}), do: abs(ax - bx) < 2 && abs(ay - by) < 2

  defp follow(%__MODULE__{} = s, head, tail) do
    {hx, hy} = Map.get(s, head)
    {tx, ty} = Map.get(s, tail)

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

    Map.put(s, tail, {tx, ty})
  end
end
