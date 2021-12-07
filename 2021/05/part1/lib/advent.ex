defmodule Advent do

  @spec eval(List.t()) :: Integer.t()
  def eval(lines \\ Advent.Input.parse()) do
    lines
    |> Enum.filter(&not_diagonal/1)
    |> Enum.reduce(%{}, &map_points/2)
    |> Enum.filter(&gt_one/1)
    |> length()
  end

  defp not_diagonal({s, e}) do
    case slope(s, e) do
      {0, y} when y != 0 -> true
      {x, 0} when x != 0 -> true
      _ -> false
    end
  end

  defp map_points(l, m), do: Enum.reduce(points(l), m, &add_point/2)
  defp add_point(p, m), do: Map.put(m, p, Map.get(m, p, 0) + 1)

  defp gt_one({_, v}) when v > 1, do: true
  defp gt_one(_), do: false

  def points({s, e}), do: points([s], slope(s, e), e)

  def points([h | _] = ps, _s, e) when h == e, do: Enum.reverse(ps)

  def points([{lx, ly} | _] = ps, {mx, my}, e) do
    points([{lx + mx, ly + my} | ps], {mx, my}, e)
  end

  def slope({sx, sy}, {ex, ey}) do
    dx = ex - sx
    dy = ey - sy
    slope(dx ,dy)
  end

  def slope(dx, dy) when dx == 0 and dy > 0, do: {0, 1}
  def slope(dx, dy) when dx == 0 and dy < 0, do: {0, -1}
  def slope(dx, dy) when dx > 0 and dy == 0, do: {1, 0}
  def slope(dx, dy) when dx < 0 and dy == 0, do: {-1, 0}

  def slope(dx, dy) do
    gd = gcd(dx, dy)
    gx = div(dx, gd)
    gy = div(dy, gd)

    if gd < 0 do
      {gx * -1, gy * -1}
    else
      {gx, gy}
    end
  end

  def gcd(d, 0), do: d
  def gcd(a, b), do: gcd(b, Integer.mod(a, b))
end
