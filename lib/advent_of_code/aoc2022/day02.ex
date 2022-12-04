defmodule AdventOfCode.AoC2022.Day2 do
  @input_mapping_part1 %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  @shape_scores %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @round_outcomes %{
    {:rock, :rock} => {3, 3},
    {:paper, :paper} => {3, 3},
    {:scissors, :scissors} => {3, 3},
    {:rock, :paper} => {0, 6},
    {:paper, :scissors} => {0, 6},
    {:scissors, :rock} => {0, 6},
    {:paper, :rock} => {6, 0},
    {:scissors, :paper} => {6, 0},
    {:rock, :scissors} => {6, 0}
  }

  def input(), do: File.read!("inputs/day02.txt")
  def example_input(), do: File.read!("inputs/day02_example.txt")

  def part1(input) do
    input
    |> parse_input(fn char -> Map.fetch!(@input_mapping_part1, char) end)
    |> Enum.map(&score_round/1)
    |> Enum.reduce(&add_scores/2)
  end

  def part2(input) do
    input
    |> parse_input(&map_char_part2/1)
    |> Enum.map(fn {opponent_shape, my_outcome} ->
      {opponent_shape, translate_strategy(opponent_shape, my_outcome)}
    end)
    |> Enum.map(&score_round/1)
    |> Enum.reduce(&add_scores/2)
  end

  defp map_char_part2("A"), do: :rock
  defp map_char_part2("B"), do: :paper
  defp map_char_part2("C"), do: :scissors
  defp map_char_part2("X"), do: :lose
  defp map_char_part2("Y"), do: :draw
  defp map_char_part2("Z"), do: :win

  defp translate_strategy(x, :draw), do: x
  defp translate_strategy(:rock, :lose), do: :scissors
  defp translate_strategy(:rock, :win), do: :paper
  defp translate_strategy(:paper, :lose), do: :rock
  defp translate_strategy(:paper, :win), do: :scissors
  defp translate_strategy(:scissors, :lose), do: :paper
  defp translate_strategy(:scissors, :win), do: :rock

  defp parse_input(input, char_mapper_fun) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn match ->
      match
      |> String.split(" ")
      |> Enum.map(char_mapper_fun)
      |> List.to_tuple()
    end)
  end

  defp score_round({left_shape, right_shape} = round) do
    round_score = Map.fetch!(@round_outcomes, round)
    shape_score = {Map.fetch!(@shape_scores, left_shape), Map.fetch!(@shape_scores, right_shape)}
    add_scores(round_score, shape_score)
  end

  defp add_scores({left_score_1, right_score_1}, {left_score_2, right_score_2}) do
    {left_score_1 + left_score_2, right_score_1 + right_score_2}
  end
end
