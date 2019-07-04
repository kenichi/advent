defmodule Advent do
  defstruct clay: MapSet.new,
            max_y: 0,
            min_y: 0,
            pool: MapSet.new,
            water: MapSet.new

  defmodule Invalid, do: defexception message: "", point: nil, state: nil

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim_trailing/1)
  end

  def read_input(stream) do
    state = Enum.reduce(stream, %Advent{}, &parse/2)
    {min_y, max_y} = miny_maxy(state)
    %Advent{state | max_y: max_y, min_y: min_y}
  end

  def parse(line, state) do
    String.split(line, ", ")
    |> Enum.map(&parse_axis/1)
    |> map_clay(state)
  end

  def parse_axis(axis) do
    [axis, value] = String.split(axis, "=")
    {String.to_atom(axis), parse_value(value)}
  end

  def parse_value(value) do
    case String.split(value, "..") do
      [b, e] -> String.to_integer(b)..String.to_integer(e)
      [v] -> String.to_integer(v)
    end
  end

  def map_clay([x: x, y: y], state), do: map_clay(x, y, state)
  def map_clay([y: y, x: x], state), do: map_clay(x, y, state)

  def map_clay(x, yb..ye, state) do
    Enum.reduce(yb..ye, state, fn y, state ->
      %Advent{state | clay: MapSet.put(state.clay, {x, y})}
    end)
  end

  def map_clay(xb..xe, y, state) do
    Enum.reduce(xb..xe, state, fn x, state ->
      %Advent{state | clay: MapSet.put(state.clay, {x, y})}
    end)
  end

  def minx_maxx(state) do
    state.clay
    |> MapSet.union(state.water)
    |> MapSet.union(state.pool)
    |> Enum.map(fn {x, _} -> x end)
    |> Enum.min_max
  end

  def miny_maxy(state) do
    Enum.map(state.clay, fn {_, y} -> y end)
    |> Enum.min_max
  end

  def get(state, p) do
    cond do
      p == {500, 0} -> :+
      MapSet.member?(state.pool, p) -> :"~"
      MapSet.member?(state.water, p) -> :|
      MapSet.member?(state.clay, p) -> :"#"
      true -> :"."
    end
  end

  def print_map(state, overload \\ %{}, io \\ :stdio) do
    {{minx, maxx}, {_miny, maxy}} = {minx_maxx(state), miny_maxy(state)}

    Enum.reduce(0..maxy, nil, fn y, _ ->
      Enum.reduce(minx..maxx, nil, fn x, _ ->

        c = overload[{x, y}] || get(state, {x, y}) |> to_string
        IO.write(io, c)

        nil
      end)
      IO.write(io, "\n")
      nil
    end)
  end

  def apply_waters(waters, state) do
    new_state =
      Enum.reduce(waters, state, fn p, s ->
        %Advent{s | water: MapSet.put(s.water, p)}
      end)

    {:watered, new_state}
  end

  def pool_water(state, p) do
    %Advent{state |
      water: MapSet.delete(state.water, p),
      pool: MapSet.put(state.pool, p)
    }
  end

  def spread_pool(state, p) do
    new_state =
      pool_water(state, p)
      |> pool_left(p)
      |> pool_right(p)

    {:pooled, new_state}
  end

  def pool_left(state, {x, y}) do
    p = {x - 1, y}
    case get(state, p) do
      :| -> pool_water(state, p) |> pool_left(p)
      :"#" -> state
      z -> raise Invalid, message: "pool_left: #{inspect(z)}", point: p, state: state
    end
  end

  def pool_right(state, {x, y}) do
    p = {x + 1, y}
    case get(state, p) do
      :| -> pool_water(state, p) |> pool_right(p)
      :"#" -> state
      z -> raise Invalid, message: "pool_right: #{inspect(z)}", point: p, state: state
    end
  end

  def water_down(%Advent{max_y: max_y} = state, {_, y}) when y + 1 > max_y, do: {:max, state}
  def water_down(state, {x, y} = from) do
    down = {x, y + 1}
    case get(state, down) do
      :. -> apply_waters([down], state)
      :| -> water_down(state, down)
      :"#" -> water_sides(state, from)
      :"~" -> water_sides(state, from)
    end
  end

  def water_sides(state, p) do
    {left, state} = water_left(state, p)
    {right, state} = water_right(state, p)

    case {left, right} do
      {:wall, :wall} -> spread_pool(state, p)

      {:pooled, :wall} -> {:pooled, state}
      {:wall, :pooled} -> {:pooled, state}

      {:wall, :max} -> {:max, state}
      {:max, :wall} -> {:max, state}
      {:max, :max} -> {:max, state}

      _lr ->
        # IO.inspect(_lr)
        {:watered, state}
    end
  end

  def can_spill?(state, {x, y}) do
    case get(state, {x, y + 1}) do
      :. -> true
      :| -> true
      _ -> false
    end
  end

  def water_left(state, {x, y}) do
    left = {x - 1, y}
    case get(state, left) do
      :. -> apply_waters([left], state)
      :"#" -> {:wall, state}
      :| ->
        if can_spill?(state, left) do
          water_down(state, left)
        else
          water_left(state, left)
        end
    end
  end

  def water_right(state, {x, y}) do
    right = {x + 1, y}
    case get(state, right) do
      :. -> apply_waters([right], state)
      :"#" -> {:wall, state}
      :| ->
        if can_spill?(state, right) do
          water_down(state, right)
        else
          water_right(state, right)
        end
    end
  end

  def water(state) do
    case water_down(state, {500, 0}) do
      {:watered, state} -> water(state)
      {:pooled, state} -> water(state)
      {:max, state} -> state
    end
  end

  def eval(file \\ "input/input.txt") do
    state =
      file_stream(file)
      |> read_input
      |> water

    total =
      MapSet.union(state.water, state.pool)
      |> Enum.filter(fn {_, y} -> y >= state.min_y end)
      |> length
    
    pool = MapSet.size(state.pool)

    %{ total: total, pool: pool }
  end

end

# stacktrace = Process.info(self(), :current_stacktrace) |> elem(1)
# IO.puts "IMEDIATE CALLER: #{stacktrace |> Enum.at(2) |> Exception.format_stacktrace_entry}"
# IO.puts "    NEXT CALLER: #{stacktrace |> Enum.at(3) |> Exception.format_stacktrace_entry}"
