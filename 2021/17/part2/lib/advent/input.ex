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

  @doc """
  target area: x=20..30, y=-10..-5
  """
  def target_area_regex() do
    ~r/target area: x=(-*\d+)..(-*\d+), y=(-*\d+)..(-*\d+)/
  end

  @spec parse(List.t()) :: Tuple.t()
  def parse([line] \\ read()) do
    target_area_regex()
    |> Regex.run(line)
    |> then(fn [_ | captures] ->
      Enum.map(captures, &String.to_integer/1)
    end)
  end
end
