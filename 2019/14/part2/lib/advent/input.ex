defmodule Advent.Input do
  def file(path \\ "../input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  def read(dev \\ file()) do
    IO.read(dev, :all)
    |> String.downcase()
    |> String.split("\n", trim: true)
    |> Enum.map(fn l ->
      String.split(l, " => ", trim: true)
      |> (fn [k, v] -> {read_v(v), read_k(k)} end).()
    end)
    |> Map.new()
  end

  defp read_k(k), do: String.split(k, ", ") |> Enum.map(&read_v/1)

  defp read_v(v) do
    String.split(v, " ")
    |> (fn [qty, chem] ->
          {String.to_atom(chem), Integer.parse(qty) |> elem(0)}
        end).()
  end
end
