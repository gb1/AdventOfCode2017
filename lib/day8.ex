defmodule Aoc.Day8 do
  
  require IEx

  def part1() do
    lines = File.read!("./input/day8.txt")
    |> String.split("\n", trim: true)
    |> Enum.map( &(String.split(&1, " ")))

    registers = init_registers lines

    {result, max} = run_instructions(registers, lines, 0) 

    #part 1
    result |> Map.values |> Enum.max |> IO.inspect

    # #part 2
    IO.inspect max
  end

  def init_registers(lines) do
    lines
    |> Enum.reduce(%{}, fn([r1, _, _, _,r2 | _rest], acc) ->
      acc |> Map.put(r1, 0) |> Map.put(r2, 0)
    end)
  end

  def run_instructions(registers, [], max) do 
    {registers, max}
  end

  def run_instructions(registers, [[reg1,op,int1,_if,reg2,comp,int2] | rest], max) do 
    {registers, max} = 
    case check?(registers[reg2], comp, String.to_integer(int2)) do
      true -> 
        op(registers, reg1, op, int1, max)
      false -> 
        {registers, max}
    end

    run_instructions(registers, rest, max)
  end

  def check?(reg, "==", val), do: reg == val
  def check?(reg, "!=", val), do: reg != val
  def check?(reg, "<", val), do: reg < val
  def check?(reg, ">", val), do: reg > val
  def check?(reg, ">=", val), do: reg >= val
  def check?(reg, "<=", val), do: reg <= val

  def op(registers, reg, "inc", value, max) do
    
    new_max = registers[reg] + String.to_integer(value)

    IO.inspect registers[reg] + String.to_integer(value)

    max = cond do
      new_max > max -> new_max
      max > new_max -> max
    end

    {registers |> Map.put(reg, registers[reg] + String.to_integer(value)), max}
  end

  def op(registers, reg, "dec", value, max) do

    new_max = registers[reg] - String.to_integer(value)

    IO.inspect registers[reg] - String.to_integer(value)
    
        max = cond do
          new_max > max -> new_max
          max > new_max -> max
        end

    {registers |> Map.put(reg, registers[reg] - String.to_integer(value)), max}
  end

end