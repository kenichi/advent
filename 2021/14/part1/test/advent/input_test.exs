defmodule Advent.InputTest do
  use ExUnit.Case

  describe "Advent.Input.parse/1" do
    test "parses input" do
      assert TestHelpers.parsed_example() == [
        # ['N','N','C','B'],

        # %{
        #   ['C','H'] => 'B',
        #   ['H','H'] => 'N',
        #   ['C','B'] => 'H',
        #   ['N','H'] => 'C',
        #   ['H','B'] => 'C',
        #   ['H','C'] => 'B',
        #   ['H','N'] => 'C',
        #   ['N','N'] => 'C',
        #   ['B','H'] => 'H',
        #   ['N','C'] => 'B',
        #   ['N','B'] => 'B',
        #   ['B','N'] => 'B',
        #   ['B','B'] => 'N',
        #   ['B','C'] => 'B',
        #   ['C','C'] => 'N',
        #   ['C','N'] => 'C'
        # }

        'NNCB',

        %{
          'CH' => 'B',
          'HH' => 'N',
          'CB' => 'H',
          'NH' => 'C',
          'HB' => 'C',
          'HC' => 'B',
          'HN' => 'C',
          'NN' => 'C',
          'BH' => 'H',
          'NC' => 'B',
          'NB' => 'B',
          'BN' => 'B',
          'BB' => 'N',
          'BC' => 'B',
          'CC' => 'N',
          'CN' => 'C'
        }
      ]
    end
  end
end
