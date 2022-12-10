# Advent of Code 2022 - Day 7 Part 1

What is the sum of the total sizes of those directories?

## Setup

Parsed into a directory tree map, with size values for files and map values
for more directories.

## Implementation

* iterate from the root, computing size if a directory
* iterate inside each directory, add to main list
* sum list

## Running

`mix run`

## Testing

`mix test`

