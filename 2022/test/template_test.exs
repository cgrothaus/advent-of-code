defmodule TemplateTest do
  use ExUnit.Case

  describe "part 1" do
    test "it works for the example input" do
      assert Template.example_input() |> Template.split_lines() |> Template.Part1.run() == 0
    end

    test "it runs on the real input" do
      Template.input()
      |> Template.split_lines()
      |> Template.Part1.run()
      |> IO.inspect(label: "part 1")
    end
  end

  describe "part 2" do
    test "it works for the example input" do
      assert Template.example_input() |> Template.split_lines() |> Template.Part2.run() == 0
    end

    test "it runs on the real input" do
      Template.input()
      |> Template.split_lines()
      |> Template.Part2.run()
      |> IO.inspect(label: "part 2")
    end
  end
end
