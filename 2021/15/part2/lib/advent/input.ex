defmodule Advent.Input do
  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
  end

  @spec parse(List.t()) :: List.t()
  def parse(content \\ read()) do
    for {line, y} <- Enum.with_index(String.split(content, "\n", trim: true)),
        {risk, x} <-
          String.split(line, "", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index(),
        into: %{} do
      {{x, y}, risk}
    end
  end
end
