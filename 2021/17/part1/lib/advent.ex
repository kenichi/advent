defmodule Advent do
  def eval([_sx, ex, sy, _ey] = target \\ Advent.Input.parse()) do
    for vx <- 0..ex, vy <- sy..(-1 * sy) do
      Advent.launch({vx, vy}, target)
    end
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn paths ->
      Enum.map(paths, &elem(&1, 1)) |> Enum.max()
    end)
    |> Enum.max()
  end

  def launch(velocity, target), do: path(velocity, target, [{0, 0}])

  def path(velocity, target, path \\ [])

  def path(_v, [sx, ex, sy, ey], [{x, y} | _] = path)
      when x >= sx and x <= ex and y >= sy and y <= ey do
    path
  end

  def path(_v, [_sx, ex, sy, _ey], [{x, y} | _])
      when x > ex or y < sy do
    nil
  end

  def path(v, t, [xy | _] = p) do
    {np, nv} = step({xy, v})
    path(nv, t, [np | p])
  end

  @doc """
  * The probe's x position increases by its x velocity.
  * The probe's y position increases by its y velocity.
  * Due to drag, the probe's x velocity changes by 1 toward the value 0; that is,
    it decreases by 1 if it is greater than 0, increases by 1 if it is less than
    0, or does not change if it is already 0.
  * Due to gravity, the probe's y velocity decreases by 1.

    iex> Advent.step({{0, 0}, {1, 1}})
    {{1, 1}, {0, 0}}

    iex> Advent.step({{0, 0}, {-2, 1}})
    {{-2, 1}, {-1, 0}}

  """
  def step({{px, py}, {vx, vy}}) do
    {
      {
        px + vx,
        py + vy
      },
      {
        cond do
          vx > 0 -> vx - 1
          vx < 0 -> vx + 1
          vx == 0 -> vx
        end,
        vy - 1
      }
    }
  end
end
