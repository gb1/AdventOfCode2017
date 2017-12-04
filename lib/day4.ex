defmodule Aoc.Day4 do
@moduledoc """
 Gone for a literate programming & TDD style today!
 Comments & doctests galore! 
"""
  

  @doc ~S"""
    solve problem

    iex> Aoc.Day4.read_file_and_solve()
    :done
  """
  def read_file_and_solve() do
    # part 1
    File.read!("./input/day4.txt")
    |> String.split("\n", trim: true)
    |> Enum.reject(&(contains_duplicate?(&1)))
    |> length
    |> IO.puts

    # part 2
    File.read!("./input/day4.txt")
    |> String.split("\n", trim: true)
    |> Enum.reject(&(contains_duplicate?(&1)))
    |> Enum.reject(&(contains_anagram?(&1)))
    |> length
    |> IO.puts

    :done
  end

  @doc ~S"""
  Checks a sentence for duplicate words

  iex> Aoc.Day4.contains_duplicate?("aa bb aa")
  true
  iex> Aoc.Day4.contains_duplicate?("aa bb cc")
  false
  """
  def contains_duplicate?(sentence) do
    sentence
    |> String.split(" ")
    |> Combination.combine(2)
    |> Enum.any?(fn([x,y]) -> x == y end)  
  end

  @doc ~S"""
  Checks a sentence for anagrams

  iex> Aoc.Day4.contains_anagram?("abcde xyz ecdab")
  true
  iex> Aoc.Day4.contains_anagram?("abcde fghij")
  false
  """
  def contains_anagram?(sentence) do
    sentence
    |> String.split(" ")
    |> Combination.combine(2)
    |> Enum.any?(fn([x,y]) -> 
      x = x |> String.graphemes |> Enum.sort
      y = y |> String.graphemes |> Enum.sort
      x == y end)  
  end

end