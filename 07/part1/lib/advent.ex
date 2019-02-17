defmodule Advent do

  @dir ~r/Step (\w) must be finished before step (\w) can begin./

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  def parse_input(input \\ read_input()) do
    Enum.reduce(input, {MapSet.new(), %{}}, fn l, {all, m} ->
      [_, parent, step] = Regex.run(@dir, l)

      {
        (MapSet.put(all, step) |> MapSet.put(parent)),
        Map.update(m, step, MapSet.new([parent]), &MapSet.put(&1, parent))
      }
    end)
  end

  def build_deps({all, deps} \\ parse_input()) do
    {
      all,
      Enum.reduce(deps, deps, fn {s, _}, nds ->
        Map.put(nds, s, recurse_deps(nds, s))
      end)
    }
  end

  def recurse_deps(deps, key) do
    Enum.reduce(deps[key], deps[key], fn d, set ->
      if deps[d] do
        MapSet.union(set, MapSet.union(deps[d], recurse_deps(deps, d)))
      else
        set
      end
    end)
  end

  def satisfied?(step, steps, deps) do
    if Map.has_key?(deps, step) do
      MapSet.subset? deps[step], MapSet.new(steps)
    else
      true
    end
  end

  def next_step(all, deps, steps) do
    ready = Enum.filter(all, fn s ->
      satisfied? s, steps, deps
    end) -- steps

    if length(ready) > 0 do
      hd Enum.sort(ready)
    else
      nil
    end
  end

  def eval({all, deps} \\ build_deps(), steps \\ []) do
    case next_step(all, deps, steps) do
      nil -> Enum.reverse(steps) |> Enum.join
      s -> eval({all, deps}, [s | steps])
    end
  end

end
