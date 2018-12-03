defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.reject(&(String.length(&1) == 0))
  end

  def common(list \\ read_input()) do
  end

  def find_match(list, s) do
  end

end
