defmodule Aoc.Day15 do 

  @a 512
  @b 191

  @a_sample 65
  @b_sample 8921

  def solve() do
    # IO.inspect part1(0, @a, @b, 0)

    IO.inspect part2(0, @a, @b, 0)
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

  def first_16_bits(i), do: Integer.to_string(i,2) |> String.reverse |> String.slice(0,16)

  def part2(5_000_000, _a, _b, matches), do: matches 
  def part2(count, a, b, matches) do
    a = next_a_2(a)
    b = next_b_2(b)
    matches = case first_16_bits(a) == first_16_bits(b) do
      true -> matches + 1
      false -> matches
    end
    part2(count+1, a, b, matches)
  end

  def next_a_2(a) do
    a = rem(a * 16807, 2147483647)
    case rem(a,4) do
      0 -> a
      _ -> next_a_2(a)
    end
  end

  def next_b_2(b) do
    b = rem(b * 48271, 2147483647)
    case rem(b,8) do
      0 -> b
      _ -> next_b_2(b)
    end
  end

end