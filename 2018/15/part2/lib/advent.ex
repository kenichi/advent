defmodule Advent do
  defmodule GameOver do
    defexception message: "game over, man!", state: nil
  end
  defmodule DeadElf do
    defexception message: "an elf has died.", state: nil
  end

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.with_index
  end

  def read_input(stream) do
    Enum.reduce(stream, {[], [], %{}}, &parse/2)
  end

  def parse({line, y}, state) do
    line
    |> String.codepoints
    |> Enum.map(&String.to_atom/1)
    |> Enum.with_index
    |> Enum.reduce(state, fn {a, x}, state ->
      parse(a, x, y, state)
    end)
  end

  def parse(:G, x, y, {elves, goblins, map}) do
    {
      elves,
      [ {x, y, 200} | goblins ],
      Map.put(map, {x, y}, :".")
    }
  end

  def parse(:E, x, y, {elves, goblins, map}) do
    {
      [ {x, y, 200} | elves ],
      goblins,
      Map.put(map, {x, y}, :".")
    }
  end

  def parse(a, x, y, {elves, goblins, map}) do
    {elves, goblins, Map.put(map, {x, y}, a)}
  end

  def get({elves, goblins, map, _ep}, p), do: get({elves, goblins, map}, p)
  def get({elves, goblins, map}, {x, y}) do
    unit? = fn {ex, ey, _} -> ex == x && ey == y end
    cond do
      Enum.find(goblins, unit?) -> :G
      Enum.find(elves, unit?) -> :E
      t = map[{x, y}] -> t
      true -> nil
    end
  end

  def get_unit({elves, goblins, _map, _ep}, {x, y}) do
    unit? = fn {ex, ey, _} -> ex == x && ey == y end
    cond do
      e = Enum.find(elves, unit?) -> e
      g = Enum.find(goblins, unit?) -> g
      true -> nil
    end
  end

  def print_map(_, overload \\ nil, io \\ :stdio)
  def print_map({e, g, map, _}, overload, io), do: print_map({e,g,map}, overload, io)
  def print_map({_, _, map} = state, overload, io) do
    coords = Map.keys(map)

    {{minx, maxx}, {miny, maxy}} =
      coords
      |> Enum.reduce({[], []}, fn {x, y}, {xs, ys} -> {[ x | xs ], [ y | ys ]} end)
      |> (fn {xs, ys} -> { Enum.min_max(xs), Enum.min_max(ys) } end).()

    Enum.reduce(miny..maxy, nil, fn y, _ ->
      Enum.reduce(minx..maxx, nil, fn x, _ ->

        if c = overload[{x, y}] do
          IO.write(io, c)
        else
          c = get(state, {x, y}) |> to_string
          IO.write(io, c)
        end

        nil
      end)
      IO.write(io, "\n")
      nil
    end)
  end

  def cartesian_distance({ax, ay, _}, {bx, by, _}) do
    cartesian_distance({ax, ay}, {bx, by})
  end
  def cartesian_distance({ax, ay}, {bx, by}) do
    abs(bx - ax) + abs(by - ay)
  end

  def friends_enemies({elves, goblins, _map, _ep}, unit) do
    cond do
      Enum.member?(elves, unit) -> {elves, goblins}
      Enum.member?(goblins, unit) -> {goblins, elves}
      true -> raise "unit not found"
    end
  end

  def possible_targets(state, unit) do
    friends_enemies(state, unit) |> elem(1)
  end

  def any_possible_targets?(state, unit, rest) do
    case possible_targets(state, unit) do
      [] -> {:halt, state}
      _ -> {:cont, state, unit, rest}
    end
  end

  def attackable({_, _, map, _}, {ux, uy, _}) do
    [
      { ux + 1, uy },
      { ux - 1, uy },
      { ux, uy + 1 },
      { ux, uy - 1 }
    ]
    |> Enum.filter(fn t -> map[t] == :"." end)
  end

  def reading_order(positions) do
    sorter = fn {ax, ay}, {bx, by} ->
      cond do
        ay < by -> true
        ay == by -> ax < bx
        ay > by -> false
      end
    end

    Enum.sort(positions, fn
      {ax, ay}, {bx, by} -> sorter.({ax, ay}, {bx, by})
      {ax, ay, _}, {bx, by, _} -> sorter.({ax, ay}, {bx, by})
    end)
  end

  def attack_target(state, unit, rest) do
    as = attackable(state, unit)

    possible_targets(state, unit)
    |> Enum.filter(fn {x, y, _hp} -> Enum.member?(as, {x, y}) end)
    |> case do
      [] ->
        # IO.puts("\tnot attacking")
        {:cont, state, unit, rest}
      as ->
        Enum.reduce(as, {[], -1}, fn {_, _, hp} = u, {l, min} ->
          cond do
            min == -1 -> {[ u | l ], hp}
            hp == min -> {[ u | l ], min}
            hp < min -> {[u], hp}
            hp > min -> {l, min}
          end
        end)
        |> elem(0)
        |> reading_order
        |> hd()
        |> attack!(state, unit, rest)
    end
  end

  def attack!({tx, ty, thp} = target, {elves, goblins, map, elf_power} = state, attacker, rest) do
    # IO.puts("\t#{inspect(attacker)} attacking #{inspect(target)}")

    find = fn e -> e == target end

    if Enum.member?(elves, attacker) do
      if (thp - elf_power) <= 0 do
        { :stop,
          {
            elves,
            List.delete_at(goblins, Enum.find_index(goblins, find)),
            map,
            elf_power
          },
          delete_from_rest(rest, find)
        }
      else
        new_target = fn _ -> {tx, ty, thp - elf_power} end
        { :stop,
          {
            elves,
            List.update_at(goblins, Enum.find_index(goblins, find), new_target),
            map,
            elf_power
          },
          update_rest(rest, find, new_target)
        }
      end
    else
      goblin_attack_elf!(target, state, rest)
    end
  end

  def goblin_attack_elf!({tx, ty, thp} = target, {elves, goblins, map, elf_power}, rest) do
    find = fn e -> e == target end
    if (thp - 3) <= 0 do
      raise DeadElf
      # { :stop,
      #   {
      #     List.delete_at(elves, Enum.find_index(elves, find)),
      #     goblins,
      #     map,
      #     elf_power
      #   },
      #   delete_from_rest(rest, find)
      # }
    else
      new_target = fn _ -> {tx, ty, thp - 3} end
      { :stop,
        {
          List.update_at(elves, Enum.find_index(elves, find), new_target),
          goblins,
          map,
          elf_power
        },
        update_rest(rest, find, new_target)
      }
    end
  end

  defp delete_from_rest(rest, find) do
    case Enum.find_index(rest, find) do
      nil -> rest
      i -> List.delete_at(rest, i)
    end
  end

  defp update_rest(rest, find, new_target) do
    case Enum.find_index(rest, find) do
      nil -> rest
      i -> List.update_at(rest, i, new_target)
    end
  end

  def in_range(state, unit) do
    possible_targets(state, unit)
    |> Enum.reduce(MapSet.new(), fn t, set ->
      open_neighbors(state, t)
      |> Enum.reduce(set, &(MapSet.put(&2, &1)))
    end)
  end

  def reachable(in_range, state, unit) do
    Enum.filter(in_range, fn p -> !is_nil(a_star(state, unit, p)) end)
  end

  def nearest(reachable, state, unit) do
    Enum.map(reachable, &({&1, a_star(state, unit, &1) |> length}))
    |> Enum.reduce({[], -1}, fn {p, d}, {l, min} ->
      cond do
        min == -1 -> {[ p | l ], d}
        d == min -> {[ p | l ], min}
        d < min -> {[p], d}
        d > min -> {l, min}
      end
    end)
    |> elem(0)
    |> Enum.reverse
  end

  def find_move_target(state, unit) do
    move_targets =
      in_range(state, unit)
      |> reachable(state, unit)
      |> nearest(state, unit)
      |> reading_order
    if length(move_targets) > 0, do: hd(move_targets), else: nil
  end

  def move_unit(state, unit, rest) do
    case find_move_target(state, unit) do
      nil ->
        # IO.puts("\tnot moving")
        {:stop, state, rest}
      goal ->
        move(state, unit, goal) 
        |> Tuple.append(rest)
    end
  end

  def find_next_step(state, {ux, uy, _}, goal) do
    open_neighbors(state, {ux, uy})
    |> Enum.map(fn n ->
      { n,
        case a_star(state, n, goal) do
          nil -> -1
          path -> length(path)
        end
      }
    end)
    |> Enum.reduce({[], -1}, fn {p, d}, {l, min} ->
      cond do
        d == -1 -> {l, min}
        min == -1 -> {[ p | l ], d}
        d == min -> {[ p | l ], min}
        d < min -> {[p], d}
        d > min -> {l, min}
      end
    end)
    |> elem(0)
    |> reading_order
    |> hd
  end

  def move({elves, goblins, map, elf_power} = state, {_, _, hp} = unit, goal) do
    {nx, ny} = find_next_step(state, unit, goal)
    # IO.puts("\tmoving to #{inspect(goal)} via #{inspect({nx,ny})}")
    new_unit = {nx, ny, hp}
    new_spot = fn _ -> new_unit end
    find = fn e -> e == unit end

    if Enum.member?(elves, unit) do
      { :cont,
        {
          List.update_at(elves, Enum.find_index(elves, find), new_spot),
          goblins,
          map,
          elf_power
        },
        new_unit
      }
    else
      { :cont,
        {
          elves,
          List.update_at(goblins, Enum.find_index(goblins, find), new_spot),
          map,
          elf_power
        },
        new_unit
      }
    end
  end

  def turn(state, _unit, rest, []), do: {:done, state, rest}
  def turn(state, unit, rest, [ step | steps ]) do
    case step.(state, unit, rest) do
      {:cont, state, unit, rest} -> turn(state, unit, rest, steps)
      {:stop, state, rest} -> {:done, state, rest}
      {:halt, state} -> {:halt, state}
    end
  end

  def do_round({elves, goblins, _map, _ep} = state) do
    elves ++ goblins
    |> reading_order
    |> do_round(state)
  end

  def do_round([], state), do: state
  def do_round([ unit | rest ], state) do
    turn(state, unit, rest, [

      &any_possible_targets?/3,
      &attack_target/3,
      &move_unit/3,
      &attack_target/3

    ])
    |> case do
      {:halt, state} -> raise GameOver, state: state
      {:done, {elves, goblins, map, ep}, rest} ->
        do_round(
          rest,
          {
            reading_order(elves),
            reading_order(goblins),
            map,
            ep
          }
        )
    end
  end

  def remaining_hp({elves, goblins, _, _}) do
    elves ++ goblins
    |> Enum.reduce(0, fn {_, _, hp}, sum -> sum + hp end)
  end

  def eval(file \\ "input/input.txt") do
    file_stream(file)
    |> read_input
    |> handle_game
  end

  def handle_game(state, elf_power \\ 3) do
    try do
      handle_round(Tuple.append(state, elf_power))
    rescue
      _ in DeadElf -> handle_game(state, elf_power + 1)
        #IO.puts("an elf died! increasing elf power to #{elf_power + 1}")
        #handle_game(state, elf_power + 1)
    end
  end

  def handle_round(state, count \\ 0) do
    # IO.puts("round: #{count}")
    # print_map(state)
    try do
      do_round(state)
      |> handle_round(count + 1)
    rescue
      go in GameOver -> count * remaining_hp(go.state)
    end
  end

  def open_neighbors(state, unit, goal \\ nil)
  def open_neighbors(state, {ux, uy, _}, goal), do: open_neighbors(state, {ux, uy}, goal)
  def open_neighbors(state, {ux, uy}, goal) do
    [
      { ux + 1, uy },
      { ux - 1, uy },
      { ux, uy + 1 },
      { ux, uy - 1 }
    ]
    |> Enum.filter(fn t ->
      if !is_nil(goal) && t == goal do
        true
      else
        get(state, t) == :"."
      end
    end)
  end

  defmodule InfinityMap do
    defstruct map: %{}

    def new(map) do
      %InfinityMap{map: map}
    end

    def gt_or_equal?(%InfinityMap{map: m}, key, value) do
      case m[key] do
        nil -> false
        n -> value >= n
      end
    end

  end

  # https://en.wikipedia.org/wiki/A*_search_algorithm
  #
  def a_star(state, {sx, sy, _}, goal), do: a_star(state, {sx, sy}, goal)
  def a_star(state, {_, _} = start, goal) do

    closed_set = MapSet.new()
    open_set = MapSet.new([start])
    came_from = %{}
    g_score = InfinityMap.new(%{start => 0})
    f_score = InfinityMap.new(%{start => cartesian_distance(start, goal)})

    a_star_loop(state, start, goal, open_set, closed_set, g_score, f_score, came_from)
  end

  def a_star_loop(
    state,
    start,
    goal,
    open_set,
    closed_set,
    g_score,
    f_score,
    came_from
  ) do

    if MapSet.size(open_set) > 0 do
      current = Enum.sort(open_set, fn a, b -> f_score.map[a] < f_score.map[b] end) |> hd()

      if current == goal do
        reconstruct_path(came_from, current, [])
      else

        open_set = MapSet.delete(open_set, current)
        closed_set = MapSet.put(closed_set, current)

        {open_set, closed_set, g_score, f_score, came_from} =

          open_neighbors(state, current, goal)
          |> Enum.reduce({open_set, closed_set, g_score, f_score, came_from}, fn n, {os, cs, gs, fs, cf} ->

            if !MapSet.member?(cs, n) do

              t_g_score = gs.map[current] + cartesian_distance(current, n)

              if MapSet.member?(os, n) && InfinityMap.gt_or_equal?(gs, n, t_g_score) do
                {os, cs, gs, fs, cf}

              else
                {
                  MapSet.put(os, n),
                  cs,
                  %{ gs | map: Map.put(gs.map, n, t_g_score)},
                  %{ fs | map: Map.put(fs.map, n, t_g_score + cartesian_distance(n, goal))},
                  Map.put(cf, n, current)
                }
              end

            else
              {os, cs, gs, fs, cf}
            end

          end)

        a_star_loop(state, start, goal, open_set, closed_set, g_score, f_score, came_from)

      end
    else
      nil
    end
  end

  def reconstruct_path(came_from, current, []) do
    reconstruct_path(came_from, came_from[current], [current])
  end

  def reconstruct_path(_came_from, nil = _current, total_path) do
    total_path
  end

  def reconstruct_path(came_from, current, total_path) do
    total_path = [ current | total_path ]
    reconstruct_path(came_from, came_from[current], total_path)
  end

end
