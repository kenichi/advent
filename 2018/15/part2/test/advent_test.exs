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
      %{},
      3
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
      {[elf | _], _, _, _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      assert Advent.in_range(state, elf) ==
        MapSet.new([{1, 3}, {2, 2}, {3, 1}, {3, 3}, {5, 1}, {5, 2}])
    end

    test "example 3" do
      {[elf | _], _, _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      assert Advent.in_range(state, elf) ==
        MapSet.new([{4, 2}, {3, 3}, {5, 3}])
    end
  end

  test "reachable" do
    {[elf | _], _, _, _} = state =
      Advent.file_stream("input/example_2.txt")
      |> Advent.read_input
      |> Tuple.append(3)

    observed = 
      Advent.in_range(state, elf)
      |> Advent.reachable(state, elf)

    assert observed == [{1, 3}, {2, 2}, {3, 1}, {3, 3}]
  end

  describe "nearest" do
    test "example 2" do
      {[elf | _], _, _, _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      observed = 
        Advent.in_range(state, elf)
        |> Advent.reachable(state, elf)
        |> Advent.nearest(state, elf)

      assert observed == [{1, 3}, {2, 2}, {3, 1}]
    end

    test "example 3" do
      {[elf | _], _, _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      observed = 
        Advent.in_range(state, elf)
        |> Advent.reachable(state, elf)
        |> Advent.nearest(state, elf)

      assert observed == [{3, 3}, {4, 2}]
    end
  end

  describe "find_move_target" do
    test "example 2" do
      {[elf | _], [gob | _], _, _} = state =
        Advent.file_stream("input/example_2.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      assert Advent.find_move_target(state, elf) == {3, 1}
      assert is_nil(Advent.find_move_target(state, gob))
    end

    test "example 3" do
      {[elf | _], _, _, _} = state =
        Advent.file_stream("input/example_3.txt")
        |> Advent.read_input
        |> Tuple.append(3)

      assert Advent.find_move_target(state, elf) == {4, 2}
    end
  end

  test "move" do
    {[elf | _], goblins, map, _} = state =
      Advent.file_stream("input/example_3.txt")
      |> Advent.read_input
      |> Tuple.append(3)

    assert Advent.move(state, elf, {3, 1}) ==
      { :cont,
        {
          [{3, 1, 200}],
          goblins,
          map,
          3
        },
        {3, 1, 200}
      }
  end

  test "move_unit" do
    {
      [elf | _],
      [gob1, gob2 | _],
      _map,
      _
    } = state =
      Advent.file_stream("input/example_2.txt")
      |> Advent.read_input
      |> Tuple.append(3)

    {:cont, {[new_elf | _], _, _, 3}, _, nil} = Advent.move_unit(state, elf, nil)
    assert new_elf == {2, 1, 200}

    {:stop, {_, [new_gob1 | _], _, 3}, nil} = Advent.move_unit(state, gob1, nil)
    assert new_gob1 == gob1

    {:cont, {_, [_, new_gob2 | _], _, 3}, _, nil} = Advent.move_unit(state, gob2, nil)
    assert new_gob2 == {2, 2, 200}
  end

  test "do_round" do
    {elves, goblins, map} =
      Advent.file_stream("input/example_4.txt")
      |> Advent.read_input

    round1 = Advent.do_round({elves, goblins, map, 3})
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
        map,
        3
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
        map,
        3
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
        map,
        3
      }
  end

  test "attack removes dead unit" do
    {elves, goblins, map, ep} =
      {
        [{2, 2, 200}],
        [{0, 0, 9}, {2, 1, 4}, {3, 2, 2}, {2, 3, 2}, {4, 4, 1}],
        for(y <- 0..4, x <- 0..4, into: %{}, do: {{x, y}, :"."}),
        3
      }
    [ elf | rest ] = elves ++ goblins

    assert Advent.attack_target({elves, goblins, map, ep}, elf, rest) ==
      { :stop,
        {
          [{2, 2, 200}],
          [{0, 0, 9}, {2, 1, 4}, {2, 3, 2}, {4, 4, 1}],
          map,
          3
        },
        [{0, 0, 9}, {2, 1, 4}, {2, 3, 2}, {4, 4, 1}]
      }
  end

  test "eval" do
    assert Advent.eval("input/example_5.txt") == 4988
    # assert Advent.eval("input/example_6.txt") == 31284
    assert Advent.eval("input/example_7.txt") == 31284
    assert Advent.eval("input/example_8.txt") == 3478
    assert Advent.eval("input/example_9.txt") == 6474
    assert Advent.eval("input/example_10.txt") == 1140
  end

end
