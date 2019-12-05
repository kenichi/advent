defmodule Advent do

  defmodule Cart, do: defstruct x: -1, y: -1, turns: 0, dir: nil

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.with_index
  end

  def read_input(stream) do
    Enum.reduce(stream, {[], %{}}, &parse/2)
  end

  def print_rails({carts, rails}, io \\ :stdio) do
    coords = Map.keys(rails)

    {minx, maxx} =
      coords
      |> Enum.reduce([], fn {x, _}, l -> [ x | l ] end)
      |> Enum.min_max

    {miny, maxy} =
      coords
      |> Enum.reduce([], fn {_, y}, l -> [ y | l ] end)
      |> Enum.min_max

    Enum.reduce(miny..maxy, nil, fn y, _ ->
      Enum.reduce(minx..maxx, nil, fn x, _ ->

        c = Enum.find(carts, fn c -> c.x == x && c.y == y end)

        if c do
          IO.write(io, to_string(c.dir))
        else

          if rails[{x, y}] do
            IO.write(io, rails[{x, y}])
          else
            IO.write(io, " ")
          end

        end
        nil

      end)
      IO.write(io, "\n")
      nil
    end)
    
  end

  def parse({line, y}, state) do
    line
    |> String.codepoints
    |> Enum.map(&String.to_atom/1)
    |> Enum.with_index
    |> Enum.reduce(state, fn {a, x}, state -> parse(a, x, y, state) end)
  end

  defp parse(:^, x, y, {carts, rails}) do
    {[%Cart{x: x, y: y, dir: :^} | carts], Map.put(rails, {x, y}, :|)}
  end

  defp parse(:>, x, y, {carts, rails}) do
    {[%Cart{x: x, y: y, dir: :>} | carts], Map.put(rails, {x, y}, :-)}
  end

  defp parse(:<, x, y, {carts, rails}) do
    {[%Cart{x: x, y: y, dir: :<} | carts], Map.put(rails, {x, y}, :-)}
  end

  defp parse(:v, x, y, {carts, rails}) do
    {[%Cart{x: x, y: y, dir: :v} | carts], Map.put(rails, {x, y}, :|)}
  end

  defp parse(:" ", _, _, {carts, rails}) do
    {carts, rails}
  end

  defp parse(a, x, y, {carts, rails}) do
    {carts, Map.put(rails, {x, y}, a)}
  end

  def tick({carts, rails}) do
    try do
      carts
      |> sort_carts
      |> Enum.reduce({[], rails}, &step/2)
      |> tick
    catch
      xy -> xy
    end
  end

  def sort_carts(carts) do
    Enum.sort(carts, fn %Cart{x: ax, y: ay}, %Cart{x: bx, y: by} ->
      ax < bx || ay < by
    end)
  end

  def step(cart, {new_carts, rails}) do
    cart =
      cart
      |> move
      |> collide?(new_carts)
      |> new_dir(rails)

    case cart do
      {:error, cart} ->
        IO.warn("cart off rails:")
        IO.inspect(cart)
        exit(:error)

      cart -> 
        {[cart | new_carts], rails}
    end
  end

  defp move(%Cart{dir: :^} = cart), do: %Cart{cart | y: cart.y - 1}
  defp move(%Cart{dir: :>} = cart), do: %Cart{cart | x: cart.x + 1}
  defp move(%Cart{dir: :<} = cart), do: %Cart{cart | x: cart.x - 1}
  defp move(%Cart{dir: :v} = cart), do: %Cart{cart | y: cart.y + 1}

  defp collide?(%Cart{} = cart, carts) do
    if Enum.any?(carts, fn c -> {cart.x, cart.y} == {c.x, c.y} end) do
      throw {cart.x, cart.y}
    else
      cart
    end
  end

  defp new_dir(%Cart{} = cart, rails) do
    case dir(cart, rails[{cart.x, cart.y}]) do
      :error -> {:error, cart}
      cart   -> cart
    end
  end

  defp dir(%Cart{}, nil), do: :error

  defp dir(%Cart{} = cart, :+), do: turn(cart)

  defp dir(%Cart{dir: :^} = cart, :/), do: %Cart{cart | dir: :>}
  defp dir(%Cart{dir: :>} = cart, :/), do: %Cart{cart | dir: :^}
  defp dir(%Cart{dir: :<} = cart, :/), do: %Cart{cart | dir: :v}
  defp dir(%Cart{dir: :v} = cart, :/), do: %Cart{cart | dir: :<}

  defp dir(%Cart{dir: :^} = cart, :"\\"), do: %Cart{cart | dir: :<}
  defp dir(%Cart{dir: :>} = cart, :"\\"), do: %Cart{cart | dir: :v}
  defp dir(%Cart{dir: :<} = cart, :"\\"), do: %Cart{cart | dir: :^}
  defp dir(%Cart{dir: :v} = cart, :"\\"), do: %Cart{cart | dir: :>}

  defp dir(%Cart{dir: :<} = cart, :-), do: %Cart{cart | dir: :<}
  defp dir(%Cart{dir: :>} = cart, :-), do: %Cart{cart | dir: :>}

  defp dir(%Cart{dir: :^} = cart, :|), do: %Cart{cart | dir: :^}
  defp dir(%Cart{dir: :v} = cart, :|), do: %Cart{cart | dir: :v}

  defp turn(%Cart{} = cart) do
    {dir, turn} = case cart.turns do
      0 -> {turn_left(cart.dir), 1}
      1 -> {cart.dir, 2}
      2 -> {turn_right(cart.dir), 0}
    end

    %Cart{cart | dir: dir, turns: turn}
  end

  defp turn_left(:^), do: :<
  defp turn_left(:>), do: :^
  defp turn_left(:<), do: :v
  defp turn_left(:v), do: :>

  defp turn_right(:^), do: :>
  defp turn_right(:>), do: :v
  defp turn_right(:<), do: :^
  defp turn_right(:v), do: :<

  def eval(file \\ "input/input.txt") do
    file
    |> file_stream
    |> read_input
    |> tick
  end

end
