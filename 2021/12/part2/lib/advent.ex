defmodule Advent do
  def eval(map \\ Advent.Input.parse()) do
    map
    |> build_paths()
    |> length()
  end

  def init_path(), do: {["start"], false}

  def build_paths(map, {path, twice} \\ init_path(), paths \\ []) do
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
    # if already visited a single small cave twice
    #
    ps = Enum.filter(ps, fn [c | rest] ->
      if twice and small?(c) and c in rest do
        false
      else
        true
      end
    end)
    
    # iterate through any left
    Enum.reduce(ps, paths, fn [c | rest] = p, paths ->
      t = twice or (small?(c) and c in rest)
      build_paths(map, {p, t}, paths)
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
