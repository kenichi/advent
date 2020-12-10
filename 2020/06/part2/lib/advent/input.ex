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
  [["c", "b", "a"], []]

  """
  @spec parse(List.t()) :: List.t()
  def parse(forms \\ read()) do
    Enum.map(forms, fn form ->
      answers = String.split(form, "\n", trim: true)

      form
      |> String.replace("\n", "", global: true)
      |> String.split("", trim: true)
      |> Enum.uniq()
      |> Enum.reduce([], fn c, l ->
        if Enum.all?(answers, &String.contains?(&1, c)), do: [c | l], else: l
      end)
    end)
  end
end
