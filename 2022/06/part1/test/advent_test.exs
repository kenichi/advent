defmodule AdventTest do
  use ExUnit.Case

  @test_input_1 "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
  @test_input_2 "bvwbjplbgvbhsrlpgdmjqwftvncz"
  @test_input_3 "nppdvjthqldpwncqszvftbrmjlhg"
  @test_input_4 "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
  @test_input_5 "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

  def test_sopm(input) do
    input
    |> Advent.Input.parse()
    |> Advent.start_of_packet_marker()
  end

  test "start_of_packet_marker/1 - 1" do
    assert test_sopm(@test_input_1) == 7
  end

  test "start_of_packet_marker/1 - 2" do
    assert test_sopm(@test_input_2) == 5
  end

  test "start_of_packet_marker/1 - 3" do
    assert test_sopm(@test_input_3) == 6
  end

  test "start_of_packet_marker/1 - 4" do
    assert test_sopm(@test_input_4) == 10
  end

  test "start_of_packet_marker/1 - 5" do
    assert test_sopm(@test_input_5) == 11
  end
end
