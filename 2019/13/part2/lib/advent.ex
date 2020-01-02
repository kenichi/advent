alias Advent.Intcode

defmodule Advent do
  @moduledoc false

  def list_to_map(list) do
    Enum.reduce(list, {Map.new(), 0}, fn n, {map, p} -> {Map.put(map, p, n), p + 1} end)
    |> elem(0)
  end

  def state_to_list({:halt, ic}), do: state_to_list(ic)

  def state_to_list(%Advent.Intcode{state: s}) do
    limit = Map.keys(s) |> Enum.max()
    for i <- 0..limit, do: Map.get(s, i, 0)
  end

  def make_free(%Intcode{state: s} = ic) do
    %Intcode{ic | state: Map.put(s, 0, 2)}
  end

  def operate_intcode({{_ball, _paddle, score}, %Intcode{} = ic}) do
    operate_intcode(ic, score)
  end

  def operate_intcode(%Intcode{} = ic, score \\ nil) do
    case Intcode.operate(ic) do
      {:input, ic} ->
        ic
        |> survey_output(score)
        |> move_paddle(ic)
        |> operate_intcode()

      {:halt, ic} ->
        survey_output(ic, score)
        |> elem(2)
    end
  end

  def survey_output(%Intcode{output: o}, score \\ nil) do
    Enum.reverse(o)
    |> Enum.chunk_every(3)
    |> Enum.reduce({nil, nil, score}, fn [x, y, i], {ball, paddle, score} ->
      if x == -1 and y == 0 do
        {ball, paddle, i}
      else
        case i do
          3 -> {ball, {x, y}, score}
          4 -> {{x, y}, paddle, score}
          _ -> {ball, paddle, score}
        end
      end
    end)
  end

  def move_paddle({{bx, _}, {px, _}, _} = s, %Intcode{} = ic) when bx < px,
    do: {s, %Intcode{ic | input: [-1]}}

  def move_paddle({{bx, _}, {px, _}, _} = s, %Intcode{} = ic) when bx > px,
    do: {s, %Intcode{ic | input: [1]}}

  def move_paddle({{bx, _}, {px, _}, _} = s, %Intcode{} = ic) when bx == px,
    do: {s, %Intcode{ic | input: [0]}}

  def eval() do
    Intcode.new()
    |> make_free()
    |> operate_intcode()
    |> inspect()
  end
end
