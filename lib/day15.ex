defmodule Aoc.Day15 do 

  @a 512
  @b 191

  @a_sample 65
  @b_sample 8921

  def solve() do
    part1(0, @a_sample, @b_sample, 0)
  end

  def part1(40_000_000, _a, _b, matches), do: matches 
  def part1(count, a, b, matches) do
    a = next_a(a)
    b = next_b(b)
    matches = case first_16_bits(a) == first_16_bits(b) do
      true -> matches + 1
      false -> matches
    end
    part1(count+1, a, b, matches)
  end

  def next_a(a), do: rem(a * 16807, 2147483647)
  
  def next_b(b), do: rem(b * 48271, 2147483647)

  def first_16_bits(i), do: Integer.to_string(i,2) |> String.reverse |> String.slice(0,15)

end