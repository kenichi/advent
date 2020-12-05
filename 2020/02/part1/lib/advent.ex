defmodule Advent do
  @moduledoc """
  """

  @doc """
  Return count of valid passwords.

  ## Examples

    iex> Advent.eval([{1..3, "a", "abcde"}, {1..3, "b", "cdefg"}, {2..9, "c", "ccccccccc"}])
    2

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(passwords \\ Advent.Input.parse()) do
    Enum.count(passwords, fn {range, char, pw} ->
      occurences =
        String.codepoints(pw)
        |> Enum.count(fn c -> c == char end)

      occurences in range
    end)
  end
end
