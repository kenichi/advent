defmodule Advent do
  def eval(packet \\ Advent.Input.parse()) do
    sum_packet_versions(packet)
  end

  def sum_packet_versions(packet, sum \\ 0)
  def sum_packet_versions({version, 4, _data}, sum), do: sum + version

  def sum_packet_versions({version, _type_id, packets} = packet, sum) do
    sum = sum + version
    Enum.reduce(packets, sum, &sum_packet_versions/2)
  end
end
