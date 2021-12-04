# Advent of Code 2021 - Day 4 Part 2

Once it wins, what would its final score be?

## Setup

The combination of `Enum.reduce_while/3` and multiple functions makes solving
this one almost a _reduction_ in complexity.

## Implementation

Modify our `Advent.turn/2` to just return `:cont`, and reverse our filter to
remove winning boards. Add a new `Advent.turn/2` that matches when there's only
one board left. That function will loop via `:cont` until that board wins (an
early attempt just returned the last board, but it hadn't yet "won", so the
numbers were off).

```diff
diff -r part1/lib/advent.ex part2/lib/advent.ex
6,8c6
<     {winner, called} = Enum.reduce_while(turns, boards, &turn/2)
<     called * Advent.Board.sum_of_unmarked(winner)
<   end
---
>     {last, called} = Enum.reduce_while(turns, boards, &turn/2)
10,11c8,9
<   def turn(called, boards) do
<     played = Enum.map(boards, &Board.turn(&1, called))
---
>     called * Advent.Board.sum_of_unmarked(last)
>   end
13,15c11,16
<     case Enum.filter(played, &Board.wins?/1) do
<       [winner] -> {:halt, {winner, called}}
<       [] -> {:cont, played}
---
>   def turn(called, [b]) do
>     b = Board.turn(b, called)
>     if Board.wins?(b) do
>       {:halt, {b, called}}
>     else
>       {:cont, [b]}
16a18,22
>   end
>
>   def turn(called, [_|_] = boards) do
>     played = Enum.map(boards, &Board.turn(&1, called))
>     {:cont, Enum.filter(played, fn b -> !Board.wins?(b) end)}
```

## Running

`mix run`

## Testing

`mix test`