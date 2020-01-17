defmodule Advent do
  @moduledoc false

  def batch(%{} = reactions, chem) do
    reactions
    |> Map.keys()
    |> Enum.find(fn {c, _} -> c == chem end)
    |> elem(1)
  end

  def check_extra(%{} = extra, chem, qty) do
    case extra[chem] do
      nil ->
        {qty, extra}

      ex ->
        cond do
          qty >= ex -> {qty - ex, Map.delete(extra, chem)}
          qty < ex -> {0, %{extra | chem => ex - qty}}
        end
    end
  end

  def ore_for(%{} = reactions, {chem, qty}, ore \\ 0, extra \\ %{}) do
    # do we have any extra?
    case check_extra(extra, chem, qty) do
      # had enough extra to cover this request
      {0, extra} ->
        {ore, extra}

      # still need qty chems
      {qty, extra} ->
        # chem comes in batches of
        b = batch(reactions, chem)

        # how many batches go into qty, non zero remainder?
        multiplier =
          case {div(qty, b), Integer.mod(qty, b)} do
            {m, 0} -> m
            {m, _} -> m + 1
          end

        # stash any extra
        extra =
          case multiplier * b - qty do
            0 -> extra
            ex -> Map.put(extra, chem, ex + Map.get(extra, chem, 0))
          end

        # a batch of chem needs
        case reactions[{chem, b}] do
          # chem requires only ore!
          [ore: required_ore] ->
            {required_ore * multiplier + ore, extra}

          # chem requires other chem(s)
          required_chems ->
            Enum.reduce(required_chems, {ore, extra}, fn {c, q}, {o, e} ->
              ore_for(reactions, {c, q * multiplier}, o, e)
            end)
        end
    end
  end

  def eval() do
    Advent.Input.read()
    |> ore_for({:fuel, 1})
    |> inspect()
  end
end
