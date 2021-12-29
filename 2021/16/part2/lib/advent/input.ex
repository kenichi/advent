defmodule Advent.Input do
  @spec file(String.t()) :: :file.io_device()
  def file(path \\ "input/input.txt") do
    {:ok, dev} = File.open(path)
    dev
  end

  @spec read(:file.io_device()) :: List.t()
  def read(dev \\ file()) do
    IO.read(dev, :all)
  end

  @spec parse(List.t()) :: Tuple.t()
  def parse(content \\ read()) do
    content
    |> String.trim()
    |> hex_to_binary()
    |> open()
    |> parse_packets()
    |> hd()
  end

  def open(string) do
    {:ok, pid} = StringIO.open(string)
    pid
  end

  def hex_to_binary(hex) do
    expected_bits = String.length(hex) * 4

    bin =
      hex
      |> String.to_integer(16)
      |> Integer.to_string(2)

    observed_bits = String.length(bin)

    if expected_bits == observed_bits do
      bin
    else
      pad =
        for(_ <- 1..(expected_bits - observed_bits), do: "0")
        |> Enum.join("")

      pad <> bin
    end
  end

  def parse_packets(bio, packets \\ []) do
    case parse_packet(bio) do
      nil ->
        Enum.reverse(packets)

      packet ->
        if String.match?(rcont(bio), ~r/^0+$/) do
          Enum.reverse([packet | packets])
        else
          parse_packets(bio, [packet | packets])
        end
    end
  end

  def parse_packet(bio) do
    # IO.puts("parse_packet:\t#{rcont(bio)}")

    parse_version(bio)
    |> parse_type_id(bio)
    |> case do
      {_version, :eof} ->
        nil

      {version, 4} ->
        {version, 4, parse_literal(bio)}

      {version, type_id} ->
        {version, type_id, parse_operator(bio)}
    end
  end

  def parse_version(bio) do
    case IO.read(bio, 3) do
      :eof -> :eof
      v -> String.to_integer(v, 2)
    end
  end

  def parse_type_id(:eof, _bio), do: {:eof, :eof}

  def parse_type_id(version, bio) do
    case IO.read(bio, 3) do
      :eof -> {version, :eof}
      tid -> {version, String.to_integer(tid, 2)}
    end
  end

  def parse_literal(bio, value \\ "") do
    # IO.puts("parse_literal:\t#{rcont(bio)}")
    case IO.read(bio, 5) do
      "1" <> bin -> parse_literal(bio, value <> bin)
      "0" <> bin -> String.to_integer(value <> bin, 2)
    end
  end

  def parse_operator(bio) do
    # IO.puts("parse_operator:\t#{rcont(bio)}")
    case IO.read(bio, 1) do
      "0" ->
        sub_packets_length =
          bio
          |> IO.read(15)
          |> String.to_integer(2)

        # IO.puts("length-wise #{sub_packets_length}")

        bio
        |> IO.read(sub_packets_length)
        |> open()
        |> parse_packets()

      "1" ->
        sub_packets_count =
          bio
          |> IO.read(11)
          |> String.to_integer(2)

        # IO.puts("count-wise: #{sub_packets_count}")

        for _ <- 1..sub_packets_count, do: parse_packet(bio)
    end
  end

  defp rcont(io), do: StringIO.contents(io) |> elem(0)
end
