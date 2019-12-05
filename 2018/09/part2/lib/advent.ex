defmodule Advent do

  # stolen! https://github.com/bjorng/advent-of-code-2018/blob/master/day09/lib/day09.ex
  #
  # still need to figure this out

  def eval(players, marbles) do

    scores = for i <- 1..players, into: %{}, do: {i, 0}
    circle = {[], 0, []}

    Enum.reduce(1..marbles, {circle, scores}, &place_marble/2)
    |> elem(1)
    |> Map.values
    |> Enum.max

  end

  def place_marble(marble, {circle, scores}) when rem(marble, 23) != 0 do
    {place_one(marble, circle), scores}
  end

  def place_marble(marble, {circle, scores}) do
    player = rem(marble, map_size(scores)) + 1
    circle = ensure_bef(circle)
    {bef, old_cur, aft} = circle
    aft = [old_cur | aft]

    {split_off, bef} = Enum.split(bef, 7)
    [taken, current | split_off] = Enum.reverse(split_off)
    aft = split_off ++ aft
    circle = {bef, current, aft}

    score = marble + taken
    scores = Map.update(scores, player, score, &(&1 + score))
    {circle, scores}
  end

  def place_one(marble, circle) do
    case circle do

      {[], 0, []} ->
        {[], marble, [0]}

      {bef, cur, [h | aft]} ->
        {[h, cur | bef], marble, aft}

      {bef, cur, []} ->
        [h | aft] = Enum.reverse(bef)
        {[h, cur], marble, aft}

    end
  end

  defp ensure_bef({[_, _, _, _,  _, _, _, _, _ | _], _, _} = circle), do: circle

  defp ensure_bef({bef, current, aft}) do
    {bef ++ Enum.reverse(aft), current, []}
  end

end
