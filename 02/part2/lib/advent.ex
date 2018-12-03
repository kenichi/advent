defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.reject(&(String.length(&1) == 0))
  end

  def common(list \\ read_input()) do
    Enum.reduce(list, "", fn s, common ->
      case find_match(list, s) do
        nil -> common
        m ->
          String.myers_difference(s, m)
          |> Enum.reduce("", fn {op,v}, str -> if op == :eq, do: str <> v, else: str end)
      end
    end)
  end

  def find_match(list, s) do
    l = for l <- list, count_eqs(l, s) == (String.length(s) - 1), do: l
    if length(l) > 0, do: hd(l), else: nil
  end

  def count_eqs(a, b) do
    String.myers_difference(a, b)
    |> Enum.reduce(0, fn {op,v}, c -> if op == :eq, do: String.length(v) + c, else: c end)
  end

end
