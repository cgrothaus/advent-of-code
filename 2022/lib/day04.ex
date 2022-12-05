defmodule Day4 do
  def input(), do: File.read!("inputs/day04.txt")
  def example_input(), do: File.read!("inputs/day04_example.txt")
  def split_lines(input), do: String.split(input, "\n", trim: true)

  def parse_line(line) do
    line |> String.split(",") |> Enum.map(&parse_section_assignment/1) |> List.to_tuple()
  end

  defp parse_section_assignment(assignment) do
    [start_section, end_section] =
      assignment |> String.split("-") |> Enum.map(&String.to_integer/1)

    start_section..end_section
  end
end

defmodule Day4.Part1 do
  def run(input) do
    input
    |> Enum.map(&Day4.parse_line/1)
    |> Enum.count(fn {sa1, sa2} -> fully_contained?(sa1, sa2) || fully_contained?(sa2, sa1) end)
  end

  # is range1 fully contained in range2?
  defp fully_contained?(%Range{} = range1, %Range{} = range2) do
    range1.first >= range2.first && range1.last <= range2.last
  end
end

defmodule Day4.Part2 do
  def run(input) do
    input
    |> Enum.map(&Day4.parse_line/1)
    |> Enum.count(fn {sa1, sa2} -> overlaps?(sa1, sa2) end)
  end

  defp overlaps?(range1, range2), do: !Range.disjoint?(range1, range2)
end
