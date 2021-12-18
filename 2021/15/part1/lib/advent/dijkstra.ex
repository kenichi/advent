defmodule Advent.Dijkstra do
  def shortest(graph, source \\ {0, 0}) do
    target = graph |> Map.keys() |> Enum.max()

    q = graph |> Map.keys() |> MapSet.new()

    dist =
      for(v <- q, into: %{}, do: {v, :infinity})
      |> Map.put(source, 0)

    prev = for v <- q, into: %{}, do: {v, :undefined}

    {prev, u} = process_queue({q, dist, prev}, graph, target)

    generate_path(prev, [u], source)
  end

  def process_queue({[], _dist, _prev}, _graph, _target), do: :ruhroh

  def process_queue({q, dist, prev}, graph, target) do
    u = Enum.min_by(q, &dist[&1])

    if u == target do
      {prev, u}
    else
      q = MapSet.delete(q, u)

      {dist, prev} =
        surroundings(u)
        |> Enum.reduce({dist, prev}, fn v, {d, p} ->
          if v in q do
            alt = dist[u] + graph[v]

            if alt < dist[v] do
              {Map.put(d, v, alt), Map.put(p, v, u)}
            else
              {d, p}
            end
          else
            {d, p}
          end
        end)

      process_queue({q, dist, prev}, graph, target)
    end
  end

  # NOTE: this leaves out the source from the final path
  def generate_path(prev, [u | _] = path, source) do
    case prev[u] do
      ^source -> path
      v -> generate_path(prev, [v | path], source)
    end
  end

  def surroundings({x, y}) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1}
    ]
  end
end
