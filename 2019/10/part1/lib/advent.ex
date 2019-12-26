defmodule Advent do
  @moduledoc false

  defmodule Field do
    defstruct height: 0,
              map: %{},
              station: {0, 0},
              width: 0

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
        Map.get(m, {x, y}), # atom
        {x, y},             # actual coordinate
        simplest({rx, ry})  # simplest relative coordinate
      }
    end

    defp relative_ring(rad) do
      cols = for ry <- (rad * -1)..rad, rx <- [rad * -1, rad], do: {rx, ry}
      rows = for rx <- (rad * -1)..rad, ry <- [rad * -1, rad], do: {rx, ry}

      (cols ++ rows)
      |> Enum.uniq()
    end

    defp ring(%__MODULE__{} = field, rad) do
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
    Returns an `Integer` of visible "asteroids" (`:#`) from the `station` coordinates
    in the given `field`.

    ## Examples

        iex> Advent.Input.parse([~w[. # #], ~w[# . .], ~w[. . .]])
        ...> |> Advent.Field.visible_asteroid_count()
        ...> |> elem(2)
        2


    """
    def visible_asteroid_count(%__MODULE__{height: h, width: w} = field) do
      acc = {
        field,
        MapSet.new(), # blocks
        0             # count
      }

      1..Enum.max([h, w])
      |> Enum.reduce_while(acc, &(ring(field, &1) |> visible_asteroid_reduce(&2)))
    end

    defp visible_asteroid_reduce([], acc), do: {:halt, acc}
    defp visible_asteroid_reduce(ring, {%__MODULE__{} = f, blocks, count}) do
      {blocks, count} =
        ring
        |> Enum.reduce({blocks, count}, fn
          {:., _, _}, acc -> acc
          {:"#", _, {rx, ry}}, {b, c} ->
            if MapSet.member?(b, {rx, ry}) do
              {b, c}
            else
              {MapSet.put(b, {rx, ry}), c + 1}
            end
        end)

      {:cont, {f, blocks, count}}
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
      |> Field.visible_asteroid_count()
    end)
    |> Enum.max_by(&elem(&1, 2))
    |> (fn {%Field{station: {sx, sy}}, _, count} -> {{sx, sy}, count} end).()
  end

  def eval() do
    best_station()
    |> inspect()
  end
end
