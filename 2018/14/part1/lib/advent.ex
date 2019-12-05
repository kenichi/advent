defmodule Advent do

  # ETS implementation seems slightly faster...
  #
  # defmodule Score do
  #   defstruct size: 0

  #   def new() do
  #     :ets.new(:score, [:named_table])
  #     %Score{}
  #   end

  #   def new(enum) do
  #     push(new(), enum)
  #   end

  #   def push(score, enum) do
  #     Enum.reduce(enum, score, fn s, score -> Score.add(score, s) end)
  #   end

  #   def add(score, i) do
  #     :ets.insert(:score, {score.size, i})
  #     %Score{score | size: score.size + 1}
  #   end

  #   def fetch(_, idx) do
  #     case :ets.lookup(:score, idx) do
  #       [{_, i}] -> i 
  #       _ -> nil
  #     end
  #   end

  #   def slice(_, range) do
  #     Enum.reverse(range)
  #     |> Enum.reduce([], fn i, l -> [ fetch(nil, i) | l ] end)
  #   end

  #   def to_list(score) do
  #     slice(nil, 0..score.size - 1)
  #   end

  #   def size(score), do: score.size

  # end
  #
  # but, keeping the plain Map impl for now...

  defmodule Score do
    defstruct map: %{}

    def new() do
      %Score{}
    end

    def new(enum) do
      new() |> push(enum)
    end

    def push(score, enum) do
      Enum.reduce(enum, score, fn s, score -> add(score, s) end)
    end

    def add(score, i) do
      %Score{ score | map: Map.put(score.map, Score.size(score), i) }
    end

    def fetch(score, i) do
      score.map[i]
    end

    def slice(score, range) do
      Enum.reverse(range)
      |> Enum.reduce([], fn i, l -> [ fetch(score, i) | l ] end)
    end

    def to_list(score) do
      slice(score, 0..Score.size(score) - 1)
    end

    def size(score), do: Map.size(score.map)

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

  def make_recipes(recipes, {score, elves} \\ {Score.new([3, 7]), [0, 1]}) do
    if Score.size(score) > recipes do
      {score, elves}
    else
      make_recipes(recipes, new_recipe({score, elves}))
    end
  end

  def eval(recipes \\ 9) do
    {score, _} = make_recipes(recipes + 10)
    IO.puts "score.map is #{Map.size(score.map)}"
    Score.slice(score, recipes..(recipes + 9))
    |> Enum.map(&to_string/1)
    |> Enum.join
  end

end
