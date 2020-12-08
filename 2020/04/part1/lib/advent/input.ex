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
  Return List of Maps of passport data.

  ## Examples

  iex> Advent.Input.parse(["ecl:gry\\nbyr:1937", "iyr:2013 ecl:amb"])
  [
    %{ ecl: "gry", byr: "1937" },
    %{ iyr: "2013", ecl: "amb" }
  ]

  """
  @spec parse(List.t()) :: List.t()
  def parse(list \\ read()) do
    Enum.map(list, fn pdata ->
      pdata
      |> String.split(~r/[ \n]/, trim: true)
      |> Enum.into(%{}, fn datum ->
        datum
        |> String.split(":")
        |> (fn [k, v] -> {String.to_atom(k), v} end).()
      end)
    end)
  end
end
