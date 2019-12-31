defmodule AdventTest do
  use ExUnit.Case
  doctest Advent
  doctest Advent.Input

  def parse_example(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn l ->
      Regex.named_captures(~r/pos=<x=(?<x>[ -]\d+), y=(?<y>[ -]\d+), z=(?<z>[ -]\d+)>, vel=<x=(?<vx>[ -]\d+), y=(?<vy>[ -]\d+), z=(?<vz>[ -]\d+)>/, l)
      |> Enum.map(fn {k, v} ->
        {i, ""} = v |> String.trim() |> Integer.parse()
        {String.to_atom(k), i}
      end)
      |> Map.new()
      |> (fn m ->
        %Advent.Moon{position: %{x: m[:x], y: m[:y], z: m[:z]}, velocity: %{x: m[:vx], y: m[:vy], z: m[:vz]}}
      end).()
    end)
  end

  describe "example 1" do
    def ex_one_moons do
      """
      <x=-1, y=0, z=2>
      <x=2, y=-10, z=-7>
      <x=4, y=-8, z=8>
      <x=3, y=5, z=-1>
      """
      |> StringIO.open()
      |> elem(1)
      |> Advent.Input.read()
      |> Enum.map(&Advent.Moon.new/1)
    end

    test "step 0" do
      assert ex_one_moons() ==
               [
                 %Advent.Moon{position: %{x: -1, y: 0, z: 2}, velocity: %{x: 0, y: 0, z: 0}},
                 %Advent.Moon{position: %{x: 2, y: -10, z: -7}, velocity: %{x: 0, y: 0, z: 0}},
                 %Advent.Moon{position: %{x: 4, y: -8, z: 8}, velocity: %{x: 0, y: 0, z: 0}},
                 %Advent.Moon{position: %{x: 3, y: 5, z: -1}, velocity: %{x: 0, y: 0, z: 0}}
               ]
    end

    test "step 1" do
      observed =
        ex_one_moons()
        |> Advent.step()

      expected =
        """
        pos=<x= 2, y=-1, z= 1>, vel=<x= 3, y=-1, z=-1>
        pos=<x= 3, y=-7, z=-4>, vel=<x= 1, y= 3, z= 3>
        pos=<x= 1, y=-7, z= 5>, vel=<x=-3, y= 1, z=-3>
        pos=<x= 2, y= 2, z= 0>, vel=<x=-1, y=-3, z= 1>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 2" do
      observed =
        ex_one_moons()
        |> Advent.steps(2)

      expected =
        """
        pos=<x= 5, y=-3, z=-1>, vel=<x= 3, y=-2, z=-2>
        pos=<x= 1, y=-2, z= 2>, vel=<x=-2, y= 5, z= 6>
        pos=<x= 1, y=-4, z=-1>, vel=<x= 0, y= 3, z=-6>
        pos=<x= 1, y=-4, z= 2>, vel=<x=-1, y=-6, z= 2>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 3" do
      observed =
        ex_one_moons()
        |> Advent.steps(3)

      expected =
        """
        pos=<x= 5, y=-6, z=-1>, vel=<x= 0, y=-3, z= 0>
        pos=<x= 0, y= 0, z= 6>, vel=<x=-1, y= 2, z= 4>
        pos=<x= 2, y= 1, z=-5>, vel=<x= 1, y= 5, z=-4>
        pos=<x= 1, y=-8, z= 2>, vel=<x= 0, y=-4, z= 0>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 4" do
      observed =
        ex_one_moons()
        |> Advent.steps(4)

      expected =
        """
        pos=<x= 2, y=-8, z= 0>, vel=<x=-3, y=-2, z= 1>
        pos=<x= 2, y= 1, z= 7>, vel=<x= 2, y= 1, z= 1>
        pos=<x= 2, y= 3, z=-6>, vel=<x= 0, y= 2, z=-1>
        pos=<x= 2, y=-9, z= 1>, vel=<x= 1, y=-1, z=-1>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 5" do
      observed =
        ex_one_moons()
        |> Advent.steps(5)

      expected =
        """
        pos=<x=-1, y=-9, z= 2>, vel=<x=-3, y=-1, z= 2>
        pos=<x= 4, y= 1, z= 5>, vel=<x= 2, y= 0, z=-2>
        pos=<x= 2, y= 2, z=-4>, vel=<x= 0, y=-1, z= 2>
        pos=<x= 3, y=-7, z=-1>, vel=<x= 1, y= 2, z=-2>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 6" do
      observed =
        ex_one_moons()
        |> Advent.steps(6)

      expected =
        """
        pos=<x=-1, y=-7, z= 3>, vel=<x= 0, y= 2, z= 1>
        pos=<x= 3, y= 0, z= 0>, vel=<x=-1, y=-1, z=-5>
        pos=<x= 3, y=-2, z= 1>, vel=<x= 1, y=-4, z= 5>
        pos=<x= 3, y=-4, z=-2>, vel=<x= 0, y= 3, z=-1>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 7" do
      observed =
        ex_one_moons()
        |> Advent.steps(7)

      expected =
        """
        pos=<x= 2, y=-2, z= 1>, vel=<x= 3, y= 5, z=-2>
        pos=<x= 1, y=-4, z=-4>, vel=<x=-2, y=-4, z=-4>
        pos=<x= 3, y=-7, z= 5>, vel=<x= 0, y=-5, z= 4>
        pos=<x= 2, y= 0, z= 0>, vel=<x=-1, y= 4, z= 2>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 8" do
      observed =
        ex_one_moons()
        |> Advent.steps(8)

      expected =
        """
        pos=<x= 5, y= 2, z=-2>, vel=<x= 3, y= 4, z=-3>
        pos=<x= 2, y=-7, z=-5>, vel=<x= 1, y=-3, z=-1>
        pos=<x= 0, y=-9, z= 6>, vel=<x=-3, y=-2, z= 1>
        pos=<x= 1, y= 1, z= 3>, vel=<x=-1, y= 1, z= 3>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 9" do
      observed =
        ex_one_moons()
        |> Advent.steps(9)

      expected =
        """
        pos=<x= 5, y= 3, z=-4>, vel=<x= 0, y= 1, z=-2>
        pos=<x= 2, y=-9, z=-3>, vel=<x= 0, y=-2, z= 2>
        pos=<x= 0, y=-8, z= 4>, vel=<x= 0, y= 1, z=-2>
        pos=<x= 1, y= 1, z= 5>, vel=<x= 0, y= 0, z= 2>
        """
        |> parse_example()

      assert observed == expected
    end

    test "step 10" do
      observed =
        ex_one_moons()
        |> Advent.steps(10)

      expected =
        """
        pos=<x= 2, y= 1, z=-3>, vel=<x=-3, y=-2, z= 1>
        pos=<x= 1, y=-8, z= 0>, vel=<x=-1, y= 1, z= 3>
        pos=<x= 3, y=-6, z= 1>, vel=<x= 3, y= 2, z=-3>
        pos=<x= 2, y= 0, z= 4>, vel=<x= 1, y=-1, z=-1>
        """
        |> parse_example()

      assert observed == expected
    end
  end
end
