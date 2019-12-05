defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> hd
  end

  def eval(str) do
    letter_set(str)
    |> Enum.map(fn l ->
      {l, alchemy_reduce(remove_letter(str, l))}
    end)
    |> Enum.sort(fn {_,a},{_,b} -> a < b end)
    |> hd
    |> elem(1)
  end

  def alchemy_reduce(str) do
    String.split(str, "", trim: true)
    |> walk
    |> length
  end

  def walk(ss) do
    Enum.reduce(ss, [], fn s, l ->
      if length(l) == 0 do
        [s]
      else
        if check_couplet(hd(l), s) do
          tl(l)
        else
          [s | l]
        end
      end
    end)
  end

  def check_couplet(a, b) do
    if same_letter?(a, b) do
      if opp_polarity?(a, b) do
        true
      else
        false
      end
    else
      false
    end
  end

  def letter_set(str) do
    String.split(str, "", trim: true)
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(MapSet.new(), &MapSet.put(&2, &1))
  end

  def remove_letter(str, c) do
    c = String.downcase(c)
    String.split(str, "", trim: true)
    |> Enum.reject(fn l -> String.downcase(l) == c end)
    |> Enum.join
  end

  defp same_letter? a, b do
    String.downcase(a) == String.downcase(b)
  end

  defp opp_polarity? a, b do
    charcase(a) != charcase(b)
  end

  defp charcase c do
    if String.match?(c, ~r/^\p{Lu}$/u), do: :up, else: :down
  end

end
