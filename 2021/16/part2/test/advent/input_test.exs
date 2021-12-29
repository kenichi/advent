defmodule Advent.InputTest do
  use ExUnit.Case

  def parsed_example(which) do
    TestHelpers.example_input(which)
    |> TestHelpers.parsed_example()
  end

  describe "Advent.Input.parse/1" do
    @tag :ichi
    test "parses input" do
      assert parsed_example(1) == {6, 4, 2021}
      assert parsed_example(2) == {1, 6, [{6, 4, 10}, {2, 4, 20}]}
      assert parsed_example(3) == {7, 3, [{2, 4, 1}, {4, 4, 2}, {1, 4, 3}]}
    end
  end

  def assert_hex_equals(which, expected) do
    observed =
      TestHelpers.example_input(which)
      |> Advent.Input.read()
      |> String.trim()
      |> Advent.Input.hex_to_binary()

    assert observed == expected
  end

  describe "Advent.Input.hex_to_binary/1" do
    test "example input 1" do
      assert_hex_equals(1, "110100101111111000101000")
    end

    test "example input 2" do
      assert_hex_equals(2, "00111000000000000110111101000101001010010001001000000000")
    end

    test "example input 3" do
      assert_hex_equals(3, "11101110000000001101010000001100100000100011000001100000")
    end
  end

  def assert_parse_packet_equals(string, expected) do
    observed =
      Advent.Input.open(string)
      |> Advent.Input.parse_packet()

    assert observed == expected
  end

  describe "Advent.Input.parse_packet/1" do
    test "literal value packet" do
      assert_parse_packet_equals("110100101111111000101000", {6, 4, 2021})
    end

    test "operator packet with 0" do
      assert_parse_packet_equals(
        "00111000000000000110111101000101001010010001001000000000",
        {1, 6, [{6, 4, 10}, {2, 4, 20}]}
      )
    end

    test "operator packet with 1" do
      assert_parse_packet_equals(
        "11101110000000001101010000001100100000100011000001100000",
        {7, 3, [{2, 4, 1}, {4, 4, 2}, {1, 4, 3}]}
      )
    end
  end
end
