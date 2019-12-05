defmodule Advent do

  @r ~r/position=<\s*?([-\d]+),\s*?([-\d]+)> velocity=<\s*?([-\d]+),\s*?([-\d]+)>/

  def input_file() do
    {:ok, dev} = File.open("input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn l ->
      [x, y, dx, dy] = tl(Regex.run(@r, l)) |> Enum.map(&(String.to_integer(&1)))
      {[x,y], [dx,dy]}
    end)
  end

  def move_light({[x, y], [dx, dy]}) do
    {[x + dx, y + dy], [dx, dy]}
  end

  def show_sky(lights, print \\ false) do
    positions = Enum.map(lights, &(elem(&1,0)))
    min_x = positions |> Enum.map(fn [x,_] -> x end) |> Enum.min
    max_x = positions |> Enum.map(fn [x,_] -> x end) |> Enum.max
    min_y = positions |> Enum.map(fn [_,y] -> y end) |> Enum.min
    max_y = positions |> Enum.map(fn [_,y] -> y end) |> Enum.max

    if print do
      for y <- min_y..max_y do
        for x <- min_x..max_x do
          if Enum.any?(positions, &(&1 == [x,y])), do: "#", else: "."
        end
      end
      |> Enum.each(&IO.puts/1)

      lights
    else
      dx = max_x - min_x
      dy = max_y - min_y
      {dx, dy}
    end
  end

  def eval(lights \\ read_input(), n \\ 1) do

    {dx, dy} = show_sky(lights)
    lights = Enum.map(lights, &move_light/1)
    {ndx, ndy} = show_sky(lights)

    if ndx > dx && ndy > dy do

      # just got bigger, let's back up one
      lights = Enum.map(lights, fn {[x, y], [dx, dy]} ->
        {[x - dx, y - dy], [dx, dy]}
      end)

      IO.puts "#{ndx} #{ndy} in #{n - 1} steps"
      show_sky(lights, true)
    else
      eval(lights, n + 1)
    end
  end

end
