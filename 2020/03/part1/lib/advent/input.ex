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
  Returns a tuple with a `Map` of coordinate keys to character values and
  dimensions.

  ## Examples

  iex> Advent.Input.parse([".#", "#.", ".."])
  {
    %{
      {0, 0} => ".",
      {0, 1} => "#",
      {0, 2} => ".",
      {1, 0} => "#",
      {1, 1} => ".",
      {1, 2} => "."
    },
    2,
    3
  }

  """
  @spec parse(List.t()) :: {Map.t(), integer(), integer()}
  def parse(list \\ read()) do
    width = String.length(hd(list))
    height = length(list)

    map =
      for x <- 0..(width - 1),
          y <- 0..(height - 1),
          into: %{},
          do: {{x, y}, Enum.at(list, y) |> String.at(x)}

    {map, width, height}
  end
end
