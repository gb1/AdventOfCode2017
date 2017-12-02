defmodule Aoc.Day2 do

  def read_file_and_solve() do
    #part 1
    File.read!("./input/day2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&(checksum(String.split(&1, "\t", trim: true))))
    |> Enum.sum
    |> IO.inspect
    #part 2
    File.read!("./input/day2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&(evenly_div_checksum(String.split(&1, "\t", trim: true))))
    |> Enum.filter(&(&1 != []))
    |> List.flatten
    |> Enum.sum
  end

  def checksum(words) do
    numbers = words |> Enum.map(&(String.to_integer(&1)))
    min = numbers |> Enum.min
    max = numbers |> Enum.max
    max - min
  end  

  def evenly_div_checksum(words) do
    words 
    |> Enum.map(&(String.to_integer(&1)))
    |> Combination.combine(2)
    |> Enum.filter(fn([x,y]) -> 
      rem(x,y) == 0 || rem(y,x) == 0
    end)
    |> Enum.map(fn([x,y]) -> 
      cond do
        x > y -> x / y
        x < y -> y / x
      end
    end)
  end

end