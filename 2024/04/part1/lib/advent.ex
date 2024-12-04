defmodule Advent do
  @moduledoc false

  defstruct map: %{}, maxx: 0, maxy: 0

  @type coord :: {integer(), integer()}

  @type wordsearch :: %{coord() => String.t()}

  @type t :: %__MODULE__{
          map: wordsearch(),
          maxx: non_neg_integer(),
          maxy: non_neg_integer()
        }

  @type direction :: :n | :ne | :e | :se | :s | :sw | :w | :nw

  @directions %{
    n: {0, 1},
    ne: {1, 1},
    e: {1, 0},
    se: {1, -1},
    s: {0, -1},
    sw: {-1, -1},
    w: {-1, 0},
    nw: {-1, 1}
  }

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_xmas()
  end

  @doc """
  Count occurences of XMAS.
  """
  @spec count_xmas(Advent.t()) :: integer()
  def count_xmas(advent) do
    advent
    |> find_xs()
    |> count_occurences(advent)
  end

  @spec find_xs(Advent.t()) :: [coord()]
  defp find_xs(advent) do
    for x <- 0..advent.maxx, y <- 0..advent.maxy, advent.map[{x, y}] == "X", do: {x, y}
  end

  @spec count_occurences([coord()], t()) :: integer()
  defp count_occurences(xs, advent) when is_list(xs) do
    Enum.reduce(xs, 0, fn coord, count ->
      count + count_occurences(coord, advent)
    end)
  end

  @spec count_occurences(coord(), t()) :: integer()
  defp count_occurences(coord, advent) when is_tuple(coord) do
    Enum.reduce(Map.keys(@directions), 0, fn dir, count ->
      if xmas?(advent, coord, dir) do
        count + 1
      else
        count
      end
    end)
  end

  @spec xmas?(t(), coord(), direction()) :: boolean()
  defp xmas?(advent, start, dir) do
    case coords_in_dir(start, dir, advent) do
      :error ->
        false

      coords ->
        Enum.reduce(coords, [], fn c, cs -> [advent.map[c] | cs] end) ==
          ["X", "M", "A", "S"]
    end
  end

  @spec coords_in_dir(coord(), direction(), t()) :: [coord()] | :error
  defp coords_in_dir(start, dir, advent) do
    Enum.reduce_while(1..3, [start], fn _, [last | _] = coords ->
      case apply_dir(@directions[dir], last, advent) do
        {:ok, next} ->
          {:cont, [next | coords]}

        :error ->
          {:halt, :error}
      end
    end)
  end

  @spec apply_dir(coord(), coord(), t()) :: {:ok, coord()} | :error
  defp apply_dir({dx, dy}, {x, y}, %__MODULE__{maxx: maxx, maxy: maxy}) do
    {nx, ny} = {x + dx, y + dy}

    if nx >= 0 and nx <= maxx and ny >= 0 and ny <= maxy do
      {:ok, {nx, ny}}
    else
      :error
    end
  end
end
