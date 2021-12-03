defmodule Advent.Input do
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

  @spec parse(List.t()) :: List.t()
  def parse(list \\ read()) do
    Enum.map(list, fn
      "forward " <> n -> {:f, String.to_integer(n)}
      "up " <> n -> {:u, String.to_integer(n)}
      "down " <> n -> {:d, String.to_integer(n)}
    end)
  end
end