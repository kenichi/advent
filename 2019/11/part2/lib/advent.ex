alias Advent.Intcode
alias Advent.Robot

defmodule Advent do
  @moduledoc false

  def list_to_map(list) do
    Enum.reduce(list, {Map.new(), 0}, fn n, {map, p} -> {Map.put(map, p, n), p + 1} end)
    |> elem(0)
  end

  def state_to_list(%Advent.Intcode{state: s}) do
    limit = Map.keys(s) |> Enum.max()
    for i <- 0..limit, do: Map.get(s, i, 0)
  end

  def puts_panels({_ic, %Robot{panels: ps} = r}) do
    coords = Map.keys(ps)
    {minx, maxx} =
      coords
      |> Enum.map(&elem(&1, 0))
      |> Enum.min_max()

    {miny, maxy} =
      coords
      |> Enum.map(&elem(&1, 1))
      |> Enum.min_max()

    Enum.each(maxy..miny, fn y ->
      Enum.each(minx..maxx, fn x ->
        c =
          case Robot.panel_at(r, {x, y}) do
            0 -> "."
            1 -> "#"
            nil -> "_"
          end

        IO.write(c)
      end)

      IO.write("\n")
    end)

    nil
  end

  # ---

  def operate_robot(intcode \\ Intcode.new(), robot \\ %Robot{}) do
    Intcode.operate(intcode)
    |> case do
      {:halt, %Intcode{} = ic} ->
        {ic, robot}

      {:input, %Intcode{output: [dir, col | _]} = ic} ->
        r =
          robot
          |> Robot.paint(col)
          |> Robot.turn(dir)
          |> Robot.move()

        Robot.camera(r)
        |> Intcode.input(ic)
        |> operate_robot(r)
    end
  end

  def eval() do
    operate_robot()
    |> puts_panels()
    |> inspect()
  end
end
