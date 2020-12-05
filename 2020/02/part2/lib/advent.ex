defmodule Advent do
  @moduledoc """
  """

  @doc """
  Return count of valid passwords.

  ## Examples

    iex> Advent.eval([{[0,2], "a", "abcde"}, {[0,2], "b", "cdefg"}, {[1,8], "c", "ccccccccc"}])
    1

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(passwords \\ Advent.Input.parse()) do
    Enum.count(passwords, fn {indices, char, pw} ->
      pw_chars = String.codepoints(pw)
      Enum.map(indices, fn i -> Enum.at(pw_chars, i) == char end)
      |> case do
        [true, false] -> true
        [false, true] -> true
        _ -> false
      end
    end)
  end
end
