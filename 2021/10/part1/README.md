# Advent of Code 2021 - Day 10 Part 1

What is the total syntax error score for those errors?

## Setup

"Parsing" into list of list of single character strings is easy enough. We use
String lists instead of charlists because... well cause I started matching
against `"<"` instead of `'<'`.

## Implementation

We walk the list, building our stack, and open or close blocks along the way,
depending on the current opening. Guarding for this current block, we easily see
which lines are corrupted. No need to ignore others, they don't cause errors.

## Running

`mix run`

## Testing

`mix test`
