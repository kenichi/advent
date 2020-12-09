defmodule Advent do
  @moduledoc false

  @doc """
  Return highest seat id.
  """
  @spec eval(List.t()) :: integer()
  def eval(passes \\ Advent.Input.read()) do
    Enum.map(passes, &seat_id/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> hd()
  end

  @doc """
  Decode seat id.

  ## Examples

  iex> Advent.seat_id("FBFBBFFRLR")
  357

  iex> Advent.seat_id("BFFFBBFRRR")
  567

  iex> Advent.seat_id("FFFBBBFRRR")
  119

  iex> Advent.seat_id("BBFFBBFRLL")
  820
  """
  def seat_id(pass) do
    row =
      pass
      |> String.slice(0, 7)
      |> String.split("", trim: true)
      |> decode_row()

    col =
      pass
      |> String.slice(7, 3)
      |> String.split("", trim: true)
      |> decode_col()

    row * 8 + col
  end

  @doc """
  Decode row number by binary space partitioning.

  ## Examples

  iex> Advent.decode_row(["F", "B", "F", "B", "B", "F", "F"])
  44

  iex> Advent.decode_row(["B", "F", "F", "F", "B", "B", "F"])
  70

  iex> Advent.decode_row(["F", "F", "F", "B", "B", "B", "F"])
  14

  iex> Advent.decode_row(["B", "B", "F", "F", "B", "B", "F"])
  102

  """
  def decode_row(row, min \\ 0, max \\ 127)
  def decode_row([], min, max) when min == max, do: max
  def decode_row([ dir | row], min, max) do
    mid = ((max - min) |> div(2)) + min
    case dir do
      "F" -> decode_row(row, min, mid)
      "B" -> decode_row(row, mid + 1, max)
    end
  end

  @doc """
  Decode column number by binary space partitioning.

  ## Examples

  iex> Advent.decode_col(["R", "L", "R"])
  5

  iex> Advent.decode_col(["R", "R", "R"])
  7

  iex> Advent.decode_col(["R", "L", "L"])
  4

  """
  def decode_col(col, min \\ 0, max \\ 7)
  def decode_col([], min, max) when min == max, do: max
  def decode_col([ dir | col], min, max) do
    mid = ((max - min) |> div(2)) + min
    case dir do
      "L" -> decode_col(col, min, mid)
      "R" -> decode_col(col, mid + 1, max)
    end
  end
end
