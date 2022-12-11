defmodule Day6Test do
  use ExUnit.Case

  describe "part 1" do
    test "it works for the example input" do
      assert "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" |> Day6.Part1.run() == 11
    end

    test "it runs on the real input" do
      Day6.input()
      |> Day6.split_lines()
      |> Day6.Part1.run()
      |> IO.inspect(label: "part 1")
    end
  end

  describe "part 2" do
    test "it works for the example input" do
      assert "mjqjpqmgbljsphdztnvjfqwrcgsmlb" |> Day6.Part2.run() == 19
    end

    test "it runs on the real input" do
      Day6.input()
      |> Day6.split_lines()
      |> Day6.Part2.run()
      |> IO.inspect(label: "part 2")
    end
  end
end
