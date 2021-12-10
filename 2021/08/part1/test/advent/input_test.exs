defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      observed = TestHelpers.parsed_example()

      expected = [
        {~w[be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb],
         ~w[fdgacbe cefdb cefbgd gcbe]},
        {~w[edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec],
         ~w[fcgedb cgb dgebacf gc]},
        {~w[fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef], ~w[cg cg fdcagb cbg]},
        {~w[fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega],
         ~w[efabcd cedba gadfec cb]},
        {~w[aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga],
         ~w[gecf egdcabf bgf bfgea]},
        {~w[fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf],
         ~w[gebdcfa ecba ca fadegcb]},
        {~w[dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf],
         ~w[cefg dcbef fcge gbcadfe]},
        {~w[bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd],
         ~w[ed bcgafe cdgba cbgef]},
        {~w[egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg], ~w[gbdfcae bgc cg cgb]},
        {~w[gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc], ~w[fgae cfgab fg bagce]}
      ]

      assert observed == expected
    end
  end
end
