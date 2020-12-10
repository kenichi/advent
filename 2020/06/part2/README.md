# Advent of Code 2020 - Day 6 Part 2

How many unique questions were answered yes _by everyone in a group_?

## Implementation

Basically the same, but we have to count questions that *everyone* answered yes
to. So we get our set of answers per person in the group first. Then we do the
same split/uniq dance to get the list of unique yes question ids; except, this
time, we pipe it into a reduce that uses `Enum.all?/2` to see if the question id
is contained in everyone's yes answer list. If so, we "unshift" it on to the
list, in standard elixir `[ new_elem | old list ]` style (hence the need to
reverse the results in the doctest for `Advent.Input.parse/1`).

## Running

`mix run`

## Testing

`mix test`
