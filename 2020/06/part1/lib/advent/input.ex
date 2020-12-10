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
    |> String.split("\n\n", trim: true)
  end

  @doc """
  Returns List of unique yes answer groups.

  ## Examples

  iex> Advent.Input.parse(["abcx\\nabcy\\nabcz", "a\\nb\\nab"])
  [["a", "b", "c", "x", "y", "z"], ["a", "b"]]

  """
  @spec parse(List.t()) :: List.t()
  def parse(forms \\ read()) do
    Enum.map(forms, fn form ->
      form
      |> String.replace("\n", "", global: true)
      |> String.split("", trim: true)
      |> Enum.uniq()
    end)
  end
end
