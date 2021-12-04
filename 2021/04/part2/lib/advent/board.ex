defmodule Advent.Board do
  @doc """
  ## Examples
      iex> Advent.Board.turn({{0,1,2},{3,4,5},{6,7,8}}, 4)
      {{0,1,2},{3,-1,5},{6,7,8}}
  """
  def turn(board, called) do
    s = tuple_size(board) - 1

    Enum.reduce(0..s, board, fn y, b ->
      Enum.reduce(0..s, b, fn x, b ->
        if at(b, x, y) == called do
          put_at(b, x, y, -1)
        else
          b
        end
      end)
    end)
  end

  @doc """
  ## Examples
      iex> Advent.Board.sum_of_unmarked({{-1,-1,-1},{3,4,5},{6,7,8}})
      33
  """
  def sum_of_unmarked(board) do
    s = tuple_size(board) - 1

    Enum.reduce(0..s, {board, 0}, fn y, bs ->
      Enum.reduce(0..s, bs, fn x, {b, s} ->
        n = at(b, x, y)
        if n == -1, do: {b, s}, else: {b, s + n}
      end)
    end)
    |> elem(1)
  end

  @doc """
  ## Examples
      iex> Advent.Board.wins?({{-1,-1,-1},{3,4,5},{6,7,8}})
      true

      iex> Advent.Board.wins?({{0,-1,2},{3,-1,5},{6,-1,8}})
      true

      iex> Advent.Board.wins?({{0,1,-1},{3,4,-1},{6,-1,8}})
      false
  """
  def wins?(board) do
    (rows(board) ++ columns(board))
    |> Enum.any?(fn rc -> Enum.all?(rc, &(&1 == -1)) end)
  end

  @doc """
  ## Examples
      iex> Advent.Board.columns({{0,1,2},{3,4,5},{6,7,8}})
      [[0,3,6],[1,4,7],[2,5,8]]
  """
  def columns(board) do
    s = tuple_size(board) - 1

    for x <- 0..s do
      for y <- 0..s, do: at(board, x, y)
    end
  end

  @doc """
  ## Examples
      iex> Advent.Board.rows({{0,1,},{2,3}})
      [[0,1],[2,3]]
  """
  def rows(board) do
    board
    |> Tuple.to_list()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  ## Examples
      iex> Advent.Board.put_at({{0,1},{2,3}}, 1, 1, -3)
      {{0,1},{2,-3}}
  """
  def put_at(board, x, y, n) do
    row = elem(board, y)
    row = put_elem(row, x, n)
    put_elem(board, y, row)
  end

  @doc """
  ## Examples
      iex> Advent.Board.at({{0,1},{2,3}}, 1, 1)
      3
  """
  def at(board, x, y) do
    board |> elem(y) |> elem(x)
  end
end
