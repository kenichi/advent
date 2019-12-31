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
    |> (fn {_, robot} -> map_size(robot.panels) end).()
    |> inspect()
  end
end
