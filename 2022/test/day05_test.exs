defmodule Day5Test do
  use ExUnit.Case

  describe "part 1" do
    test "it works for the example input" do
      assert Day5.example_input() |> Day5.split_lines() |> Day5.Part1.run() == "CMZ"
    end

    test "it runs on the real input" do
      Day5.input()
      |> Day5.split_lines()
      |> Day5.Part1.run()
      |> IO.inspect(label: "part 1")
    end
  end

  describe "part 2" do
    test "it works for the example input" do
      assert Day5.example_input() |> Day5.split_lines() |> Day5.Part2.run() == "MCD"
    end

    test "it runs on the real input" do
      Day5.input()
      |> Day5.split_lines()
      |> Day5.Part2.run()
      |> IO.inspect(label: "part 2")
    end
  end
end
