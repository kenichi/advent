defmodule AdventTest do
  use ExUnit.Case

  @doc """
  #######
  #.G.E.#
  #E.G.E#
  #.G.E.#
  #######
  """
  test "read_input_example_1" do
    {elves, goblins, map} =
      Advent.file_stream("input/example_1.txt")
      |> Advent.read_input

    assert Enum.any?(goblins, &(&1 == {2, 1, 200}))
    assert Enum.any?(goblins, &(&1 == {3, 2, 200}))
    assert Enum.any?(goblins, &(&1 == {2, 3, 200}))
    assert length(goblins) == 3

    assert Enum.any?(elves, &(&1 == {4, 1, 200}))
    assert Enum.any?(elves, &(&1 == {1, 2, 200}))
    assert Enum.any?(elves, &(&1 == {5, 2, 200}))
    assert Enum.any?(elves, &(&1 == {4, 3, 200}))
    assert length(elves) == 4

    assert map[{0, 0}] == :"#"
    assert map[{6, 4}] == :"#"
    assert map[{2, 1}] == :"."
    assert map[{4, 1}] == :"."
    assert Map.size(map) == 35
  end

  test "possible_targets" do
    state = {
      [{1, 1, 200}],
      [{2, 2, 200}],
      %{}
    }

    assert Advent.possible_targets(state, {1, 1, 200}) == [{2, 2, 200}]
    assert Advent.possible_targets(state, {2, 2, 200}) == [{1, 1, 200}]

    assert_raise RuntimeError, fn -> Advent.possible_targets(state, {2, 3, 200}) end
  end

  test "cartesian_distance" do
    assert Advent.cartesian_distance({3, 3}, {0, 1}) == 5
    assert Advent.cartesian_distance({3, 3, 200}, {0, 1, 200}) == 5
  end

  test "reading_order" do
    assert Advent.reading_order([{4, 3}, {3, 3}]) == [{3, 3}, {4, 3}]
    assert Advent.reading_order([{4, 3, 200}, {3, 3, 100}]) == [{3, 3, 100}, {4, 3, 200}]
    assert Advent.reading_order([{3, 3}, {4, 2}]) == [{4, 2}, {3, 3}]

    ordered = for y <- 0..5, x <- 0..5, do: {x, y}
    shuffled = Enum.shuffle(ordered)

    assert Advent.reading_order(shuffled) == ordered
  end


  describe "in_range" do
    test "example 2" do
      {[elf | _], _, _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input

      assert Advent.in_range(state, elf) ==
        MapSet.new([{1, 3}, {2, 2}, {3, 1}, {3, 3}, {5, 1}, {5, 2}])
    end

    test "example 3" do
      {[elf | _], _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input

      assert Advent.in_range(state, elf) ==
        MapSet.new([{4, 2}, {3, 3}, {5, 3}])
    end
  end

  test "reachable" do
    {[elf | _], _, _} = state =
      Advent.file_stream("input/example_2.txt")
      |> Advent.read_input

    observed = 
      Advent.in_range(state, elf)
      |> Advent.reachable(state, elf)

    assert observed == [{1, 3}, {2, 2}, {3, 1}, {3, 3}]
  end

  describe "nearest" do
    test "example 2" do
      {[elf | _], _, _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input

      observed = 
        Advent.in_range(state, elf)
        |> Advent.reachable(state, elf)
        |> Advent.nearest(state, elf)

      assert observed == [{1, 3}, {2, 2}, {3, 1}]
    end

    test "example 3" do
      {[elf | _], _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input

      observed = 
        Advent.in_range(state, elf)
        |> Advent.reachable(state, elf)
        |> Advent.nearest(state, elf)

      assert observed == [{3, 3}, {4, 2}]
    end
  end

  describe "find_move_target" do
    test "example 2" do
      {[elf | _], [gob | _], _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input

      assert Advent.find_move_target(state, elf) == {3, 1}
      assert is_nil(Advent.find_move_target(state, gob))
    end

    test "example 3" do
      {[elf | _], _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input

      assert Advent.find_move_target(state, elf) == {4, 2}
    end
  end

  test "move" do
    {[elf | _], goblins, map} = state =
      Advent.file_stream("input/example_3.txt")
      |> Advent.read_input

    assert Advent.move(state, elf, {3, 1}) ==
      { :cont,
        {
          [{3, 1, 200}],
          goblins,
          map
        },
        {3, 1, 200}
      }
  end

  test "move_unit" do
    {
      [elf | _],
      [gob1, gob2 | _],
      _map
    } = state =
      Advent.file_stream("input/example_2.txt")
      |> Advent.read_input

    {:cont, {[new_elf | _], _, _}, _, nil} = Advent.move_unit(state, elf, nil)
    assert new_elf == {2, 1, 200}

    {:stop, {_, [new_gob1 | _], _}, nil} = Advent.move_unit(state, gob1, nil)
    assert new_gob1 == gob1

    {:cont, {_, [_, new_gob2 | _], _}, _, nil} = Advent.move_unit(state, gob2, nil)
    assert new_gob2 == {2, 2, 200}
  end

  test "do_round" do
    {elves, goblins, map} =
      Advent.file_stream("input/example_4.txt")
      |> Advent.read_input

    round1 = Advent.do_round({elves, goblins, map})
    assert round1 ==
      {
        [
          {4, 3, 200}
        ],
        [
          {2, 1, 200},
          {6, 1, 200},
          {4, 2, 197},
          {7, 3, 200},
          {2, 4, 200},
          {1, 6, 200},
          {4, 6, 200},
          {7, 6, 200}
        ],
        map
      }

    round2 = Advent.do_round(round1)
    assert round2 ==
      {
        [
          {4, 3, 197}
        ],
        [
          {3, 1, 200},
          {5, 1, 200},
          {4, 2, 194},
          {2, 3, 200},
          {6, 3, 200},
          {1, 5, 200},
          {4, 5, 200},
          {7, 5, 200}
        ],
        map
      }

    round3 = Advent.do_round(round2)
    assert round3 ==
      {
        [
          {4, 3, 185}
        ],
        [
          {3, 2, 200},
          {4, 2, 191},
          {5, 2, 200},
          {3, 3, 200},
          {5, 3, 200},
          {1, 4, 200},
          {4, 4, 200},
          {7, 5, 200}
        ],
        map
      }
  end

  test "attack removes dead unit" do
    {elves, goblins, map} =
      {
        [{2, 2, 200}],
        [{0, 0, 9}, {2, 1, 4}, {3, 2, 2}, {2, 3, 2}, {4, 4, 1}],
        for(y <- 0..4, x <- 0..4, into: %{}, do: {{x, y}, :"."})
      }
    [ elf | rest ] = elves ++ goblins

    assert Advent.attack_target({elves, goblins, map}, elf, rest) ==
      { :stop,
        {
          [{2, 2, 200}],
          [{0, 0, 9}, {2, 1, 4}, {2, 3, 2}, {4, 4, 1}],
          map
        },
        [{0, 0, 9}, {2, 1, 4}, {2, 3, 2}, {4, 4, 1}],
      }
  end

  test "entire sample" do
    {elves, goblins, map} =
      Advent.file_stream("input/example_5.txt")
      |> Advent.read_input

    assert Advent.reading_order(elves) ==
      [{4, 2, 200}, {5, 4, 200}]
    assert Advent.reading_order(goblins) ==
      [{2, 1, 200}, {5, 2, 200}, {5, 3, 200}, {3, 4, 200}]

    round1 = Advent.do_round({elves, goblins, map})
    assert round1 ==
      {
        [{4, 2, 197}, {5, 4, 197}],
        [{3, 1, 200}, {5, 2, 197}, {3, 3, 200}, {5, 3, 197}],
        map
      }

    round2 = Advent.do_round(round1)
    assert round2 ==
      {
        [{4, 2, 188}, {5, 4, 194}],
        [{4, 1, 200}, {3, 2, 200}, {5, 2, 194}, {5, 3, 194}],
        map
      }

    round23 = Enum.reduce(3..23, round2, fn _, state -> Advent.do_round(state) end)
    assert round23 ==
      {
        [{5, 4, 131}],
        [{4, 1, 200}, {3, 2, 200}, {5, 2, 131}, {5, 3, 131}],
        map
      }

    round24 = Advent.do_round(round23)
    assert round24 ==
      {
        [{5, 4, 128}],
        [{3, 1, 200}, {4, 2, 131}, {3, 3, 200}, {5, 3, 128}],
        map
      }

    round25 = Advent.do_round(round24)
    assert round25 ==
      {
        [{5, 4, 125}],
        [{2, 1, 200}, {3, 2, 131}, {5, 3, 125}, {3, 4, 200}],
        map
      }

    round26 = Advent.do_round(round25)
    assert round26 ==
      {
        [{5, 4, 122}],
        [{1, 1, 200}, {2, 2, 131}, {5, 3, 122}, {3, 5, 200}],
        map
      }

    round27 = Advent.do_round(round26)
    assert round27 ==
      {
        [{5, 4, 119}],
        [{1, 1, 200}, {2, 2, 131}, {5, 3, 119}, {4, 5, 200}],
        map
      }

    round28 = Advent.do_round(round27)
    assert round28 ==
      {
        [{5, 4, 113}],
        [{1, 1, 200}, {2, 2, 131}, {5, 3, 116}, {5, 5, 200}],
        map
      }

    round47 = Enum.reduce(29..47, round28, fn _, state -> Advent.do_round(state) end)
    assert round47 ==
      {
        [],
        [{1, 1, 200}, {2, 2, 131}, {5, 3, 59}, {5, 5, 200}],
        map
      }

    assert Advent.possible_targets(round47, elem(round47, 1) |> hd) == []
    assert elem(round47, 1) |> Enum.reduce(0, fn {_, _, hp}, sum -> hp + sum end) == 590
  end

  test "eval" do
    assert Advent.eval("input/example_5.txt") == 27730
    assert Advent.eval("input/example_6.txt") == 36334
    assert Advent.eval("input/example_7.txt") == 39514
    assert Advent.eval("input/example_8.txt") == 27755
    assert Advent.eval("input/example_9.txt") == 28944
    assert Advent.eval("input/example_10.txt") == 18740
  end

end
