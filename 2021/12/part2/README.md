# Advent of Code 2021 - Day 12 Part 2

Given these new rules, how many paths through this cave system are there?

## Setup

Now, we've got to account for:

> big caves can be visited any number of times, a single small cave can be
> visited at most twice, and the remaining small caves can be visited at most
> once.

## Implementation

At first, I tried a test during the filter for repeats. This resulted in
slightly slower tests, but a program that didn't seem to finish. This was my
tester:

```elixir
def small_twice?(path) do
  Enum.filter(path, &small?/1)
  |> Enum.frequencies()
  |> Enum.any?(fn {_, v} -> v > 1 end)
end
```

As you can see, this would take at least 3 passes through the path. I
refactored the paths to be tuples with flags, and set the flag when "building"
the path (down in the final reduce). This only optimized a bit more, the
resulting program takes 3m, oof. But... it works!

## Running

`mix run`

## Testing

`mix test`
