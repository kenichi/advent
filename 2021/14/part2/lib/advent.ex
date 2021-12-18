defmodule Advent do
  def eval([template, rules] \\ Advent.Input.parse()) do
    {{_, min}, {_, max}} =
      template
      |> count_pairs()
      |> repeat_insert(rules)
      |> count_elements()
      |> Enum.min_max_by(&elem(&1, 1))

    max - min
  end

  def count_pairs(template) do
    template
    |> Enum.chunk_every(2, 1, [nil])
    |> Enum.frequencies()
  end

  def count_elements(template) do
    Enum.group_by(template, &hd(elem(&1, 0)), &elem(&1, 1))
    |> Enum.map(fn {k, cs} -> {k, Enum.sum(cs)} end)
  end

  def repeat_insert(template, rules, steps \\ 40) do
    Enum.reduce(1..steps, template, fn _step, t -> insert_step(t, rules) end)
  end

  def insert_step(template, rules) do
    Enum.reduce(template, %{}, fn {[a, b] = p, c}, t ->
      case rules[p] do
        nil ->
          Map.put(t, p, c)

        d -> 
          p1 = [a] ++ d
          p2 = d ++ [b]

          t 
          |> Map.put(p1, Map.get(t, p1, 0) + c)
          |> Map.put(p2, Map.get(t, p2, 0) + c)
      end
    end)
  end
end
