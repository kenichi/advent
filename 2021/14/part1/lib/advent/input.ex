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
    [template, rules] = String.split(content, "\n\n", trim: true)

    tcl = to_charlist(template)

    rs =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(fn r ->
        String.split(r, " -> ")
        |> Enum.map(&to_charlist/1)
      end)
      |> Enum.map(&List.to_tuple/1)
      |> Map.new()

    [tcl, rs]
  end
end
