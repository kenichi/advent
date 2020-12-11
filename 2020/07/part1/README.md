# Advent of Code 2020 - Day 7 Part 1

How many bags can hold a shiny gold bag?

## Implementation

Mostly in the parsing again. We want to end up with a `Map` of all the colors (as
atoms ex. `:shiny_gold`) and `Keyword` list values of containable bag colors.
Using this mapping, we can traverse the (hopefully acyclic) graph until we
either end up at nothing ("no other bags" becomes `nil`) or the color we're
looking for.

Start by splitting each line on " bags contain ". This gives us the color and
what it can contain. We join the color words and make the atom. The parser uses
a `Regex` to match out the color words from the quanities in the content string.
Returning a tuple of color and quatity results in our keyword list, as we're
mapping over the content, which was split on comma.

`can_hold?/3` is our graph walker. The one situation where we return true is if
the desired color is found in the content keyword list of the holding color, and
it's quantity is more than zero. If not, we check the colors our holding bag can
contain, or return false if none.

`eval/1` becomes a simple counter that checks each color in the map,
incrementing if it can hold a shiny gold bag.

## Running

`mix run`

## Testing

`mix test`
