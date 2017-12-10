defmodule Aoc.Day9 do
  
  def part1() do
    
    input = File.read!("./input/day9.txt") |> String.trim

    input 
    |> parse(0,0,0)
  end

  def parse("", _level, count, garbage) do
    #part 1
    IO.inspect count
    #part 2
    IO.inspect garbage
  end

  def parse("{" <> rest, level, count, garbage) do
    parse(rest, level + 1, count, garbage)
  end

  def parse("}" <> rest, level, count, garbage) do
    parse(rest, level - 1, count + level, garbage)
  end

  def parse("," <> rest, level, count, garbage) do
    parse(rest, level, count, garbage)
  end

  def parse("!" <> <<_::bytes-size(1)>> <>rest, level, count, garbage) do
    parse(rest, level, count, garbage)
  end
  
  #garbage starts...
  def parse("<" <> rest, level, count, garbage) do
    {rest, new_garbage}  = remove_garbage(rest, garbage)

    parse(rest, level, count, new_garbage)
  end

  def clear_current_groups(input) do
    Regex.replace(~r/{}/, input, "")
  end

  def remove_garbage(">" <> rest, garbage) do
    {rest, garbage}
  end

  def remove_garbage("!" <> <<_::bytes-size(1)>> <> rest, garbage) do
    remove_garbage(rest, garbage)
  end
  
  def remove_garbage(<<_::bytes-size(1)>> <> rest, garbage) do
    # IO.inspect garbage
    garbage = garbage + 1
    remove_garbage(rest, garbage )
  end
  
end