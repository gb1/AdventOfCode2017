defmodule Aoc.Day11 do
  
  def solve() do
    {{x, y}, max} = File.read!("./input/day11.txt") |> String.trim
    |> String.split(",")
    |> move({0, 0}, 0)
    
    #part 1
    IO.inspect abs(x) + abs(y)
    #part 2
    IO.inspect max
  end

  def move([], position, max), do: {position, max}
  def move([direction | tail], {x, y}, max) do
    position = case direction do
      "n" -> {x, y - 1}
      "ne" -> {x + 1, y - 1}
      "se" -> {x + 1, y}
      "s" -> {x, y + 1}
      "sw" -> {x - 1, y + 1}
      "nw" -> {x - 1, y}
    end

    {x, y} = position
    max = cond do
      (abs(x) + abs(y)) > max -> abs(x) + abs(y)
      true -> max
    end

    move(tail, position, max)
  end

end