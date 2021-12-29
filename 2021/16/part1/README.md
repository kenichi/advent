# Advent of Code 2021 - Day 16 Part 1

Decode the structure of your hexadecimal-encoded BITS transmission; what do you
get if you add up the version numbers in all packets?

## Setup

I started with a charlist of "bits", then realized `StringIO` is really what I
wanted. This lets one pass around a PID to an IO-like, based on the string.

Parsing according to the rules took a minute to debug after that. Always little
bugs. Eventually settled on "peeking" ahead at the end of the packet and
stopping if the rest of the bits were zeros, meaning adding padding from hex.

Hopefully, we're set up for the inevitable operating implementations in part 2.

## Implementation

Once we had our parsed packets, summing the versions was fairly straight-
forward. Always nice to use a function that fits `Enum.reduce/3` so well.

## Running

`mix run`

## Testing

`mix test`
