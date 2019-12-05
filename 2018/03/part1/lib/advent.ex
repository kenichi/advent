defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
  end

  def parse_input(list \\ read_input()) do
    Enum.map(list, fn l ->
      String.split(l, "", trim: true)
      |> Enum.reduce({%Claim{}, %ClaimState{}}, &handle_char(&1,&2))
    end)
    |> Enum.map(fn {claim, cs} ->
      %Claim{claim | size: {elem(claim.size, 0), String.to_integer(cs.value)}}
    end)
  end

  def handle_char(c, {claim, cs}) do
    case c do
      " " -> {claim, cs}
      "#" -> {claim, cs}
      "@" -> {
          %Claim{claim | id: String.to_integer(cs.value)},
          %ClaimState{state: :origin_zero}}
      "," -> {
          %Claim{claim | origin: {String.to_integer(cs.value), elem(claim.origin, 1)}},
          %ClaimState{state: :origin_one}}
      ":" -> {
          %Claim{claim | origin: {elem(claim.origin, 0), String.to_integer(cs.value)}},
          %ClaimState{state: :size_zero}}
      "x" -> {
          %Claim{claim | size: {String.to_integer(cs.value), elem(claim.size, 1)}},
          %ClaimState{state: :size_one}}
      d ->
        case cs.value do
          nil -> {claim, %ClaimState{cs | value: d}}
          _ -> {claim, %ClaimState{cs | value: cs.value <> d}}
        end
    end
  end

  def apply_claim(claim) do
    {ox, ex} = {elem(claim.origin, 0), elem(claim.origin, 0) + elem(claim.size, 0) - 1}
    {oy, ey} = {elem(claim.origin, 1), elem(claim.origin, 1) + elem(claim.size, 1) - 1}
    Enum.reduce(ox..ex, [], fn x, cs ->
      Enum.reduce(oy..ey, cs, fn y, cs -> cs ++ [{x,y}] end)
    end)
  end

  def count_shared_squares(claims) do
    {_, count} = Enum.map(claims, &apply_claim/1)
                 |> Enum.reduce({MapSet.new(), MapSet.new()}, &handle_claim/2)
    MapSet.size(count)
  end

  defp handle_claim(claim, c) do
    Enum.reduce(claim, c, fn coord, {claimed, contested} ->
      if MapSet.member?(claimed, coord) do
        {claimed, MapSet.put(contested, coord)}
      else
        {MapSet.put(claimed, coord), contested}
      end
    end)
  end

end
