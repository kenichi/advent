defmodule Advent do
  def eval([template, rules] \\ Advent.Input.parse()) do
    repeat_insert(template, rules)
    |> Enum.frequencies()
    |> Enum.sort(fn {_, a}, {_, b} -> a > b end)
    |> then(fn sorted_freqs ->
      most = hd(sorted_freqs) |> elem(1)
      least = Enum.reverse(sorted_freqs) |> hd() |> elem(1)
      most - least
    end)
  end

  def repeat_insert(template, rules, steps \\ 10) do
    Enum.reduce(1..steps, template, fn _step, t -> insert_step(t, rules) end)
  end

  def insert_step(template, rules) do
    template
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce([hd(template)], fn [_a, b] = k, t ->
      case rules[k] do
        nil -> t ++ [b]
        i -> t ++ i ++ [b]
      end
    end)
  end
end
