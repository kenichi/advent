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

  @cross [{0, 0}, {0, 2}, {1, 1}, {2, 0}, {2, 2}]

  @x_mases [
    # M.S
    # .A.
    # M.S
    ~w[M S A M S],

    # M.M
    # .A.
    # S.S
    ~w[M M A S S],

    # S.S
    # .A.
    # M.M
    ~w[S S A M M],

    # S.M
    # .A.
    # S.M
    ~w[S M A S M]
  ]

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_x_mas()
  end

  @doc """
  Count occurences of X-MAS.
  """
  @spec count_x_mas(Advent.t()) :: integer()
  def count_x_mas(advent) do
    advent
    |> find_sorms()
    |> count_occurences(advent)
  end

  @spec find_sorms(Advent.t()) :: [coord()]
  defp find_sorms(advent) do
    for x <- 0..advent.maxx, y <- 0..advent.maxy, advent.map[{x, y}] in ~w[M S], do: {x, y}
  end

  @spec count_occurences([coord()], t()) :: integer()
  defp count_occurences(xs, advent) do
    Enum.reduce(xs, 0, fn coord, count ->
      count + if(x_mas?(advent, coord), do: 1, else: 0)
    end)
  end

  @spec x_mas?(t(), coord()) :: boolean()
  defp x_mas?(advent, start) do
    case coords_in_x(start, advent) do
      :error ->
        false

      coords ->
        Enum.reduce(coords, [], fn c, cs -> [advent.map[c] | cs] end) in @x_mases
    end
  end

  @spec coords_in_x(coord(), t()) :: [coord()] | :error
  defp coords_in_x({x, y}, %__MODULE__{maxx: maxx, maxy: maxy}) do
    Enum.reduce_while(@cross, [], fn {dx, dy}, l ->
      {nx, ny} = {x + dx, y + dy}

      if nx >= 0 and nx <= maxx and ny >= 0 and ny <= maxy do
        {:cont, [{nx, ny} | l]}
      else
        {:halt, :error}
      end
    end)
  end
end
