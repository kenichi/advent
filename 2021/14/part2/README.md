# Advent of Code 2021 - Day 14 Part 2

What do you get if you take the quantity of the most common element and
subtract the quantity of the least common element?

## Setup

> Might regret this if the next part is run it a 1,000 times or something.

40 times, and I think I regret this. Might have to rethink the impl. Watching
[the stream](https://www.twitch.tv/josevalim/video/1234192113) halfway takes me
to the solution of using a map of pairs. Let's see how far I get before I have
to go watch more.

## Implementation

Fell into the same trap, trying to remove from the existing template instead of
just creating a new "polymer" each time. This "ohhhhh" moment in the stream
saved me (about 45:15) too. Then, I thought heh I somehow did it better, I can
still use `:discard` on the charlist `chunk_every` - nope. The counting at the
end will be off by one if you do (counts 1st of pairs). Just to prove I didn't
crib wholesale, I used `nil` instead ;)

## Running

`mix run`

## Testing

`mix test`
