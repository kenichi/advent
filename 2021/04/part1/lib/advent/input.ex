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
  def parse([turns | boards] \\ read()) do
    turns =
      turns
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Enum.chunk_every(5)
      |> Enum.map(fn board ->
        Enum.map(board, fn row ->
          String.split(row)
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()
        end)
        |> List.to_tuple()
      end)

    {turns, boards}
  end
end
