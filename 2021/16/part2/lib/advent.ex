defmodule Advent do
  def eval(packet \\ Advent.Input.parse()) do
    eval_packet(packet)
  end

  def eval_packet({_version, 0, packets}) do
    packets
    |> Enum.map(&packet_value/1)
    |> Enum.sum()
  end

  def eval_packet({_version, 1, packets}) do
    packets
    |> Enum.map(&packet_value/1)
    |> Enum.product()
  end

  def eval_packet({_version, 2, packets}) do
    packets
    |> Enum.min_by(&packet_value/1)
    |> packet_value()
  end

  def eval_packet({_version, 3, packets}) do
    packets
    |> Enum.max_by(&packet_value/1)
    |> packet_value()
  end

  def eval_packet({_version, 5, packets}) do
    [a, b] = Enum.map(packets, &packet_value/1)
    if a > b, do: 1, else: 0
  end

  def eval_packet({_version, 6, packets}) do
    [a, b] = Enum.map(packets, &packet_value/1)
    if a < b, do: 1, else: 0
  end

  def eval_packet({_version, 7, packets}) do
    [a, b] = Enum.map(packets, &packet_value/1)
    if a == b, do: 1, else: 0
  end

  def packet_value({_version, 4, literal}), do: literal
  def packet_value(packet), do: eval_packet(packet)

  def sum_packet_versions(packet, sum \\ 0)
  def sum_packet_versions({version, 4, _data}, sum), do: sum + version

  def sum_packet_versions({version, _type_id, packets}, sum) do
    sum = sum + version
    Enum.reduce(packets, sum, &sum_packet_versions/2)
  end
end
