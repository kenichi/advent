defmodule AdventTest do
  use ExUnit.Case

  @input """
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-04 00:36] falls asleep
    [1518-11-01 00:25] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-04 00:46] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-05 00:45] falls asleep
    [1518-11-02 00:40] falls asleep
    [1518-11-02 00:50] wakes up
    [1518-11-03 00:24] falls asleep
    [1518-11-03 00:29] wakes up
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-01 00:55] wakes up
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-01 00:05] falls asleep
    [1518-11-05 00:55] wakes up
    """

  test "read_input" do
    {:ok, dev} = StringIO.open("""
      foo
      bar
      baz
      """)
    assert Advent.read_input(dev) == ["foo","bar","baz"]
  end

  test "parse_input" do
    {:ok, d} = Date.new(1518, 11, 1)
    {:ok, t} = Time.new(23, 58, 0)

    assert Advent.parse_input(["[1518-11-01 23:58] Guard #99 begins shift"]) ==
      [%{date: d, time: t, action: "Guard #99 begins shift"}]
  end

  test "parse_line" do
    {:ok, d} = Date.new(1518, 11, 1)
    {:ok, t} = Time.new(23, 58, 0)

    assert Advent.parse_line("[1518-11-01 23:58] Guard #99 begins shift") ==
      %{date: d, time: t, action: "Guard #99 begins shift"}
  end

  test "sort_input" do
    {:ok, d1} = Date.new(1518, 2, 2)
    {:ok, t1} = Time.new(0, 40, 0)
    {:ok, d2} = Date.new(1518, 3, 1)
    {:ok, t2} = Time.new(0, 45, 0)

    assert Advent.sort_input([
      %{date: d2, time: t2, action: "falls asleep"},
      %{date: d1, time: t1, action: "falls asleep"}
    ]) == [
      %{date: d1, time: t1, action: "falls asleep"},
      %{date: d2, time: t2, action: "falls asleep"}
    ]
  end

  test "build_guards" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev)
    |> Advent.parse_input()
    |> Advent.sort_input()
    |> Advent.build_guards() == [
      %Guard{id: 10, schedules: [24..28, 30..54, 5..24]},
      %Guard{id: 99, schedules: [45..54, 36..45, 40..49]},
    ]
  end

  test "id_times_minute" do
    {:ok, dev} = StringIO.open(@input)
    assert Advent.read_input(dev)
           |> Advent.parse_input()
           |> Advent.sort_input()
           |> Advent.build_guards()
           |> Advent.id_times_minute() == 240
  end

end
