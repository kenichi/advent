defmodule Advent do

  defmodule Score do
    defstruct size: 0

    def new() do
      :ets.new(:score, [:named_table])
      %Score{}
    end

    def new(enum) do
      push(new(), enum)
    end

    def push(score, enum) do
      Enum.reduce(enum, score, fn s, score -> Score.add(score, s) end)
    end

    def add(score, i) do
      :ets.insert(:score, {score.size, i})
      %Score{score | size: score.size + 1}
    end

    def fetch(_, idx) do
      case :ets.lookup(:score, idx) do
        [{_, i}] -> i 
        _ -> nil
      end
    end

    def slice(_, range) do
      Enum.reverse(range)
      |> Enum.reduce([], fn i, l -> [ fetch(nil, i) | l ] end)
      |> Enum.map(&to_string/1)
      |> Enum.join
    end

    def to_list(score) do
      slice(nil, 0..score.size - 1)
    end

    def size(score), do: score.size

  end

  def new_score({score, elves}) do
    recipe =
      Enum.reduce(elves, 0, fn e, sum -> sum + Score.fetch(score, e) end)
      |> Integer.digits

    {Score.push(score, recipe), elves}
  end

  def new_elves({score, elves}) do
    elves =
      Enum.reduce(elves, [], fn e, ne ->
        steps = rem(Score.fetch(score, e) + 1, Score.size(score))

        ni = cond do
          (steps + e) > Score.size(score) -> e + steps - Score.size(score)
          (steps + e) == Score.size(score) -> 0
          true -> e + steps
        end

        [ni | ne]
      end)
      |> Enum.reverse

    {score, elves}
  end

  def new_recipe({score, elves}) do
    {score, elves}
    |> new_score
    |> new_elves
  end

  def score?(score, input, offset \\ 0) do
    finish = Score.size(score) - 1 - offset
    start  = Score.size(score) - String.length(input) - offset
    slice = Score.slice(score, start..finish)
    if slice == input, do: start, else: false
  end

  def eval(input, {score, elves} \\ {Score.new([3, 7]), [0, 1]}) do

    {score, elves} = new_recipe({score, elves})

    cond do
      n = score?(score, input) -> n
      m = score?(score, input, 1) -> m
      true -> eval(input, {score, elves})
    end

  end

end
