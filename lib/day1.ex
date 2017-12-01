defmodule Aoc.Day1 do

  def read_file_and_solve() do
    captcha = File.read!("./input/day1.txt")
    |> String.split("", trim: true)
    
    # part 1
    IO.inspect solve_captcha(captcha, length(captcha) - 1, 1, 0)
    # part 2
    IO.inspect solve_captcha(captcha, length(captcha) - 1, round(length(captcha) / 2), 0)
  end
  
  def solve_captcha(_captcha, -1, _step, count), do: count
  def solve_captcha(captcha, i, step, count) do
    cond do
      Enum.at(captcha, i) == Enum.at(captcha ++ captcha, i + step) ->
        solve_captcha(captcha, i - 1, step, count + String.to_integer(Enum.at(captcha,i)))
      true ->
        solve_captcha(captcha, i - 1, step, count)
    end
  end
end