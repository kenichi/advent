ExUnit.start()

defmodule TestHelpers do
  @example1 "D2FE28"
  @example2 "38006F45291200"
  @example3 "EE00D40C823060"
  @example4 "8A004A801A8002F478"
  @example5 "620080001611562C8802118E34"
  @example6 "C0015000016115A2E0802F182340"
  @example7 "A0016C880162017C3686B18A3D4780"

  @example8 "C200B40A82"
  @example9 "04005AC33890"
  @example10 "880086C3E88112"
  @example11 "CE00C43D881120"
  @example12 "D8005AC2A8F0"
  @example13 "F600BC2D8F"
  @example14 "9C005AC2F8F0"
  @example15 "9C0141080250320F1802104A08"

  def example_input(which \\ 1) do
    {:ok, pid} =
      case which do
        1 -> @example1
        2 -> @example2
        3 -> @example3
        4 -> @example4
        5 -> @example5
        6 -> @example6
        7 -> @example7

        8 -> @example8
        9 -> @example9
        10 -> @example10
        11 -> @example11
        12 -> @example12
        13 -> @example13
        14 -> @example14
        15 -> @example15
      end
      |> StringIO.open()

    pid
  end

  def parsed_example(input \\ example_input()) do
    input
    |> Advent.Input.read()
    |> Advent.Input.parse()
  end
end
