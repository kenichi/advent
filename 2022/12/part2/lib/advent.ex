defmodule Advent do
  @moduledoc false

  defmodule PrioritizedList do
    def add([{cw, _cv} | _] = pl, {w, _v} = e) when w <= cw, do: [e | pl]
    def add([head | tail], e), do: [head | add(tail, e)]
    def add([], e), do: [e]
  end

  alias PrioritizedList, as: PL

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> ascent_steps()
  end

  def ascent_steps({map, starts, finish}) do
    starts
    |> Enum.map(&ascent_steps_from(map, &1, finish))
    |> Enum.min()
  end

  defp ascent_steps_from(map, start, finish) do
    queue = [{0, start}]
    dist = %{start => 0}

    process_queue({queue, dist}, map, finish)
  end

  defp filtered_steps(map, point) do
    height = Map.get(map, point)

    point
    |> available_steps()
    |> filter_available(map, height)
  end

  defp available_steps({x, y}) do
    [
      {x, y - 1},
      {x, y + 1},
      {x - 1, y},
      {x + 1, y}
    ]
  end

  defp filter_available(steps, map, current_height) do
    Enum.filter(steps, fn crd ->
      case Map.get(map, crd) do
        nil ->
          false

        height ->
          1 >= height - current_height
      end
    end)
  end

  defp process_queue({[], _dist}, _map, _finish), do: :ruhroh

  defp process_queue({queue, dist}, map, finish) do
    [{_priority, crd} | queue] = queue

    if crd == finish do
      dist[crd]
    else
      {queue, dist}
      |> process_steps_from(crd, map)
      |> process_queue(map, finish)
    end
  end

  defp process_steps_from({queue, dist}, crd, map) do
    map
    |> filtered_steps(crd)
    |> Enum.reduce({queue, dist}, reduce_steps(crd))
  end

  defp reduce_steps(crd) do
    fn step, {queue, dist} ->
      alt = dist[crd] + 1

      if alt < dist[step] do
        {PL.add(queue, {alt, step}), Map.put(dist, step, alt)}
      else
        {queue, dist}
      end
    end
  end
end
