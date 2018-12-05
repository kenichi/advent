defmodule Advent do

  @line ~r/^\[(\d+?)-(\d+?)-(\d+?) (\d+?):(\d+?)\] (.+)$/
  @action ~r/Guard \#(\d+?) begins shift/

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  def parse_input(lines \\ read_input()) do
    Enum.map(lines, &parse_line/1)
  end

  def parse_line(line) do
    [_, year, month, day, hour, min, action] = Regex.run(@line, line)

    [year, month, day, hour, min] = Enum.map(
      [year, month, day, hour, min],
      &String.to_integer(&1))

    {:ok, d} = Date.new(year, month, day)
    {:ok, t} = Time.new(hour, min, 0)
    %{date: d, time: t, action: action}
  end

  def sort_input(lines \\ parse_input()) do
    Enum.sort(lines, fn a, b ->
      case Date.compare(a.date, b.date) do
        :gt -> false
        :lt -> true
        :eq ->
          case Time.compare(a.time, b.time) do
            :gt -> false
            :lt -> true
            :eq -> IO.puts("what now?")
          end
      end
    end)
  end

  def build_guards(parsed) do
    Enum.reduce(parsed, %{cid: -1}, fn e, gmap ->
      case e[:action] do
        "falls asleep" -> guard_slept(gmap, e.time.minute)
        "wakes up" -> guard_woke(gmap, e.time.minute)
        s ->
          case Regex.run(@action, s) do
            [_, id] -> Map.put(gmap, :cid, String.to_integer(id))
            _ -> gmap
          end
      end
    end)
    |> Enum.reject(fn {k,_} -> k == :cid end)
    |> Enum.map(fn {id, list} ->
      %Guard{id: id, schedules: Enum.map(list, fn s -> elem(s,0)..elem(s,1) end)}
    end)
  end

  defp guard_slept(gmap, min) do
    case gmap[gmap[:cid]] do
      nil -> Map.put(gmap, gmap[:cid], [{min,nil}])
      list -> Map.put(gmap, gmap[:cid], [{min,nil} | list])
    end
  end

  defp guard_woke(gmap, min) do
    list = gmap[gmap[:cid]]
    Map.put(
      gmap,
      gmap[:cid],
      [put_elem(hd(list),1, (min - 1)) | tl(list)]
    )
  end

  def id_times_minute(guards) do
    msg = hd(Enum.sort(guards, fn a, b -> Guard.total_sleeps(a) > Guard.total_sleeps(b) end))
    msg.id * Guard.most_slept(msg)
  end

end
