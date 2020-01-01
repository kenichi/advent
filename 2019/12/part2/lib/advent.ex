defmodule Advent do
  @moduledoc false

  defmodule Moon do
    defstruct position: %{x: 0, y: 0, z: 0}, velocity: %{x: 0, y: 0, z: 0}

    def new(%{x: _x, y: _y, z: _z} = position) do
      %__MODULE__{position: position}
    end

    def potential(%__MODULE__{position: %{x: x, y: y, z: z}}) do
      abs(x) + abs(y) + abs(z)
    end

    def kinetic(%__MODULE__{velocity: %{x: x, y: y, z: z}}) do
      abs(x) + abs(y) + abs(z)
    end

    def total_energy(%__MODULE__{} = moon) do
      potential(moon) * kinetic(moon)
    end
  end

  def steps(moons, 0), do: moons
  def steps(moons, times), do: moons |> step() |> steps(times - 1)

  def step(moons) do
    moons
    |> gravity()
    |> velocity()
  end

  def pairs() do
    [
      {0, 1},
      {0, 2},
      {0, 3},
      {1, 2},
      {1, 3},
      {2, 3}
    ]
  end

  def gravity(moons) do
    pairs()
    |> Enum.reduce(moons, fn {j, k}, moons ->
      {a, b} =
        [:x, :y, :z]
        |> Enum.reduce({Enum.at(moons, j), Enum.at(moons, k)}, fn axis, {a, b} ->
          gravitate(a, b, axis)
        end)

      moons
      |> List.update_at(j, fn _ -> a end)
      |> List.update_at(k, fn _ -> b end)
    end)
  end

  def gravitate(%Moon{} = a, %Moon{} = b, axis \\ :x) do
    if a.position[axis] == b.position[axis] do
      {a, b}
    else
      if a.position[axis] > b.position[axis] do
        {
          %Moon{a | velocity: Map.put(a.velocity, axis, a.velocity[axis] - 1)},
          %Moon{b | velocity: Map.put(b.velocity, axis, b.velocity[axis] + 1)}
        }
      else
        {
          %Moon{a | velocity: Map.put(a.velocity, axis, a.velocity[axis] + 1)},
          %Moon{b | velocity: Map.put(b.velocity, axis, b.velocity[axis] - 1)}
        }
      end
    end
  end

  def velocity(moons) do
    Enum.map(moons, fn m ->
      %Moon{
        m
        | position: %{
            x: m.position[:x] + m.velocity[:x],
            y: m.position[:y] + m.velocity[:y],
            z: m.position[:z] + m.velocity[:z]
          }
      }
    end)
  end

  def pattern(moons, axis, prev_states \\ MapSet.new(), count \\ 0) do
    moons = step(moons)
    state = axial_state(moons, axis)

    if MapSet.member?(prev_states, state) do
      count
    else
      pattern(moons, axis, MapSet.put(prev_states, state), count + 1)
    end
  end

  def axial_state(moons, axis) do
    Enum.map(moons, fn %Moon{position: p, velocity: v} -> {p[axis], v[axis]} end)
  end

  def first_repeat(moons) do
    xc = pattern(moons, :x)
    yc = pattern(moons, :y)
    zc = pattern(moons, :z)
    lcm(xc, lcm(yc, zc))
  end

  defp lcm(a, b), do: div(a * b, Integer.gcd(a, b))

  def eval() do
    Advent.Input.read()
    |> Enum.map(&Moon.new/1)
    |> first_repeat()
    |> inspect()
  end
end
