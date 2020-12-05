defmodule Advent.Input do
  @moduledoc """
  """

  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  @doc """
  Return tuples of range, character, and password.

  ## Examples

    iex> Advent.Input.parse(["1-3 a: abcde","1-3 b: cdefg","2-9 c: ccccccccc"])
    [{[0,2], "a", "abcde"}, {[0,2], "b", "cdefg"}, {[1,8], "c", "ccccccccc"}]

  """
  @spec parse(List.t()) :: List.t()
  def parse(list \\ read()) do
    Enum.map(list, fn s ->
      String.split(s)
      |> List.to_tuple()
      |> parse_range()
      |> parse_char()
    end)
  end

  defp parse_range({range, char, pw}) do
    range =
      range
      |> String.split("-")
      |> Enum.map(fn s -> String.to_integer(s) - 1 end)

    {range, char, pw}
  end

  defp parse_char({range, char, pw}) do
    char = String.trim_trailing(char, ":")

    {range, char, pw}
  end
end
