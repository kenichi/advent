defmodule Advent.Dijkstra do
  defmodule PrioritizedList do
    def add([{cw, _cv} | _] = pl, {w, _v} = e) when w <= cw, do: [e | pl]
    def add([head | tail], e), do: [head | add(tail, e)]
    def add([], e), do: [e]
  end

  alias PrioritizedList, as: PL

  def shortest(graph, source \\ {0, 0}) do
    target = graph |> Map.keys() |> Enum.max()
    queue = PL.add([], {0, source})
    dist = Map.put(%{}, source, 0)
    process_queue({queue, dist}, graph, target)
  end

  def process_queue({[], _dist}, _graph, _target), do: :ruhroh

  def process_queue({queue, dist}, graph, target) do
    [{_w, u} | queue] = queue 

    if u == target do
      dist[u]
    else

      {dist, queue} =
        surroundings(u)
        |> Enum.reduce({dist, queue}, fn v, {d, q} ->
          if Map.has_key?(graph, v) do
            alt = dist[u] + graph[v]

            if alt < dist[v] do
              {Map.put(d, v, alt), PL.add(q, {alt, v})}
            else
              {d, q}
            end
          else
            {d, q}
          end
        end)

      process_queue({queue, dist}, graph, target)
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
