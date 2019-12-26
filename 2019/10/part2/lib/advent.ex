defmodule Advent do
  @moduledoc false

  defmodule Field do
    defstruct height: 0,
              map: %{},
              station: {0, 0},
              width: 0

    defmodule Laser do
      def deltas({ax, ay}, {bx, by}), do: {by - ay, bx - ax}

      def fire(%Field{station: {sx, _sy} = station}, asteroids) do
        Enum.sort(asteroids, fn {ax, _ay} = a, {bx, _by} = b ->
          qa = quadrant(station, a)
          qb = quadrant(station, b)

          if qa == qb do
            cond do
              sx == ax and sx == bx -> raise("should not be visible")
              sx == ax -> true
              sx == bx -> false
              true -> slope(station, a) < slope(station, b)
            end
          else
            qa < qb
          end
        end)
      end

      def quadrant(station, asteroid) do
        {dy, dx} = deltas(station, asteroid)

        cond do
          dy < 0 and dx >= 0 -> 0
          dy >= 0 and dx > 0 -> 1
          dy > 0 and dx <= 0 -> 2
          dy <= 0 and dx < 0 -> 3
        end
      end

      def slope(a, b), do: deltas(a, b) |> (fn {dy, dx} -> dy / dx end).()
    end

    @doc """
    Returns a `List` of the results of calling `fun` with the given `field`, and each
    "coordinate" (`{x, y}`) of an "asteroid" (`:#`).

    ## Examples

        iex> Advent.Input.parse([[".", "#"], ["#", "."]])
        ...> |> Advent.Field.each_asteroid(fn _, {x, y} -> {x, y} end)
        [{1, 0}, {0, 1}]

    """
    def each_asteroid(%__MODULE__{height: h, map: m, width: w} = field, fun) do
      for y <- 0..(h - 1), x <- 0..(w - 1) do
        case Map.get(m, {x, y}) do
          :. -> nil
          :"#" -> fun.(field, {x, y})
        end
      end
      |> Enum.filter(&(!is_nil(&1)))
    end

    defp relative_at(%__MODULE__{map: m, station: {sx, sy}}, {rx, ry}) do
      x = sx + rx
      y = sy + ry

      {
        # atom
        Map.get(m, {x, y}),
        # actual coordinate
        {x, y},
        # simplest relative coordinate
        simplest({rx, ry})
      }
    end

    def relative_ring(rad) do
      cols = for ry <- (rad * -1)..rad, rx <- [rad * -1, rad], do: {rx, ry}
      rows = for rx <- (rad * -1)..rad, ry <- [rad * -1, rad], do: {rx, ry}

      (cols ++ rows)
      |> Enum.uniq()
    end

    def ring(%__MODULE__{} = field, rad) do
      rad
      |> relative_ring()
      |> Enum.reduce([], &ring_reduce(field, &1, &2))
    end

    defp ring_reduce(%__MODULE__{} = field, c, l) do
      case relative_at(field, c) do
        {nil, _, _} -> l
        loc -> [loc | l]
      end
    end

    defp simplest({a, b}) do
      gcd = Integer.gcd(a, b)
      {trunc(a / gcd), trunc(b / gcd)}
    end

    @doc """
    Returns a `Tuple` of visible "asteroids" (`:#`) from the `station` coordinates
    in the given `field`.

    The return tuple is structured like so:

    { %Advent.Field{} per station, %MapSet of blocks, %MapSet of visible asteroids }

    ## Examples

        iex> Advent.Input.parse([~w[. # #], ~w[# . .], ~w[. . .]])
        ...> |> Advent.Field.visible_asteroids()
        ...> |> elem(2)
        ...> |> MapSet.size()
        2

    """
    def visible_asteroids(%__MODULE__{height: h, width: w} = field) do
      acc = {
        field,
        # blocks
        MapSet.new(),
        # asteroids
        MapSet.new()
      }

      1..Enum.max([h, w])
      |> Enum.reduce_while(acc, &(ring(field, &1) |> visible_asteroid_reduce(&2)))
    end

    defp visible_asteroid_reduce([], acc), do: {:halt, acc}

    defp visible_asteroid_reduce(ring, {%__MODULE__{} = f, blocks, asteroids}) do
      {blocks, asteroids} =
        ring
        |> Enum.reduce({blocks, asteroids}, fn
          {:., _, _}, acc ->
            acc

          {:"#", {x, y}, {rx, ry}}, {b, a} ->
            if MapSet.member?(b, {rx, ry}) do
              {b, a}
            else
              if MapSet.member?(a, {x, y}) do
                raise("already visible??")
              else
                {MapSet.put(b, {rx, ry}), MapSet.put(a, {x, y})}
              end
            end
        end)

      {:cont, {f, blocks, asteroids}}
    end
  end

  defmodule Input do
    def file() do
      {:ok, dev} = File.open("../input/input.txt")
      dev
    end

    def read(dev \\ file()) do
      IO.read(dev, :all)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))
    end

    @doc """
    Parses the given input data structure, a `List` of `List`s of characters, into
    a `Field`.

    ## Examples

        iex> Advent.Input.parse([[".", "#"], ["#", "."]])
        %Advent.Field{height: 2,
                      map: %{
                        {0, 0} => :".",
                        {0, 1} => :"#",
                        {1, 0} => :"#",
                        {1, 1} => :"."
                      },
                      station: {0, 0},
                      width: 2
        }
    """
    def parse(input \\ read()) do
      h = length(input)
      w = length(hd(input))

      map =
        for y <- 0..(h - 1), x <- 0..(w - 1), into: %{} do
          {
            {x, y},
            Enum.at(input, y) |> Enum.at(x) |> String.to_atom()
          }
        end

      %Field{height: h, map: map, width: w}
    end
  end

  def best_station(field \\ Input.parse()) do
    field
    |> Field.each_asteroid(fn f, {ax, ay} ->
      %Field{f | station: {ax, ay}}
      |> Field.visible_asteroids()
    end)
    |> Enum.max_by(fn {_, _, as} -> MapSet.size(as) end)
    |> (fn {%Field{station: {sx, sy}}, _, as} -> {{sx, sy}, MapSet.size(as)} end).()
  end

  def field_with_best_station(field \\ Input.parse()) do
    {station, _} = best_station(field)
    %Field{field | station: station}
  end

  def two_hundreth(field \\ field_with_best_station(), index \\ 199) do
    visible = Field.visible_asteroids(field) |> elem(2)
    vc = MapSet.size(visible)

    if vc <= index do
      %Field{field | map: MapSet.delete(field.map, visible)}
      |> two_hundreth(index - vc)
    else
      Field.Laser.fire(field, visible)
      |> Enum.at(index)
    end
  end

  def eval() do
    two_hundreth()
    |> (fn {x, y} -> x * 100 + y end).()
    |> inspect()
  end
end
