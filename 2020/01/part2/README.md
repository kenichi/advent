# Advent of Code 2020 - Day 1 Part 2

Find the *three* numbers that add to 2020 and multiply them.

## Setup

The project has been created with `mix new --app advent .`. This lays down the
basics: `mix.exs`, `lib/advent.ex`, `test/*`, etc. When using dependencies in
Elixir, one needs a mix project to work with. Also, this lets us use the mix
machinery: tasks, testing, et al. I've modified the default `application/0` in
`mix.exs` to case on `Mix.env()` so that it doesn't try to run the `Main`
application if we're testing. This also allows us to `MIX_ENV=test iex -S mix`
into a REPL without starting the `Main` app.

## Implementation

Woke up remembering about Elixir's comprehensions, which accept a "fitler"
function. This made it much less code, easier to read, and maybe faster though
I haven't timed anything.

However, since it returns a List with the results of the generating function, we
have to pipe it to `hd()` to pluck off the first of all equal elements.

## Running

`mix run`

## Testing

`mix test`
