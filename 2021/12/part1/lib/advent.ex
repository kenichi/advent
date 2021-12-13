defmodule Advent do
  def eval(map \\ Advent.Input.parse()) do
    map
    |> build_paths()
    |> length()
  end

  def build_paths(map, path \\ ["start"], paths \\ []) do
    # generate possible paths from here
    ps = next_paths(path, map)

    # find path that ends (should only ever be zero or one)
    ender =
      Enum.filter(ps, fn
        ["end" | _] -> true
        _ -> false
      end)

    # add any that end to main list (ok if empty)
    paths = paths ++ ender

    # get the rest of the possibilities
    ps = ps -- ender

    # filter any out that result in small cave repeat
    ps = Enum.filter(ps, fn [c | rest] ->
      if small?(c) do
        c not in rest
      else
        true
      end
    end)
    
    # iterate through any left
    Enum.reduce(ps, paths, fn p, paths ->
      build_paths(map, p, paths)
    end)
  end

  def small?(c), do: Regex.match?(~r/[a-z]+/, c)

  def next_paths([c | _] = path, map) do
    for e <- exits(c, map), do: [e | path]
  end

  def exits(cave, map) do
    Enum.reduce(map, [], fn
      {e, ^cave}, es when e != "start" -> [e | es]
      {^cave, e}, es when e != "start" -> [e | es]
      _, es -> es
    end)
  end
end
