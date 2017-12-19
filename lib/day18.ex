defmodule Aoc.Day18 do 


  def part1() do
    instructions = input = File.read!("./input/day18.txt") |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.map(fn(x) ->
      case String.split(x, " ") do
        [i,x,y] -> [i, convert_int(x), convert_int(y)]
        [i,x] -> [i, convert_int(x)]
      end
    end)

    run_instructions(instructions, init_registers(), 0)
  end

  def convert_int(x) do
    case Integer.parse(x) do
      {i, _x} -> i
      :error -> x
    end  
  end

  def init_registers() do
    letters = for n <- ?a..?p, do: << n :: utf8 >>
    letters
    |> Enum.reduce(%{}, fn(x,acc) ->
      Map.put(acc, x, 0)
    end)
  end

  def run_instructions(instructions, [], pos), do: :done
  def run_instructions(instructions, registers, pos) do
    inst = Enum.at(instructions, pos)

    result = case inst do
      [i, x] -> int(i, x, registers)
      [i, x, y] -> int(i, x, y, registers)
    end

    case result do
      {reg, jump} -> run_instructions(instructions, reg, pos +  jump)
      reg -> run_instructions(instructions, reg, pos + 1)
    end

  end

  @doc ~S"""
  iex> Aoc.Day18.int("snd", "x", %{"x" => 1 })
  %{:snd => 1, "x" => 1}
  """
  def int("snd", x, regs), do: regs |> Map.put(:snd, regs[x])

  @doc ~S"""
  iex> Aoc.Day18.int("set", "x", "y", %{"x" => 1, "y" => 2 })
  %{"y" => 2, "x" => 2}
  iex> Aoc.Day18.int("set", "x", 3, %{"x" => 1})
  %{"x" => 3}
  """
  def int("set", x, y, regs) when is_integer(y) do
    regs |> Map.put(x, y)
  end
  def int("set", x, y, regs) do
    regs |> Map.put(x, regs[y])
  end

  @doc ~S"""
  iex> Aoc.Day18.int("add", "x", "y", %{"x" => 1, "y" => 2 })
  %{"y" => 2, "x" => 3}
  iex> Aoc.Day18.int("add", "x", 3, %{"x" => 1})
  %{"x" => 4}
  """
  def int("add", x, y, regs) when is_integer(y) do
    regs |> Map.put(x, regs[x] + y)
  end
  def int("add", x, y, regs) do
    regs |> Map.put(x, regs[x] + regs[y])
  end

  @doc ~S"""
  iex> Aoc.Day18.int("mul", "x", "y", %{"x" => 1, "y" => 2 })
  %{"y" => 2, "x" => 2}
  iex> Aoc.Day18.int("mul", "x", 3, %{"x" => 1})
  %{"x" => 3}
  """
  def int("mul", x, y, regs) when is_integer(y) do
    regs |> Map.put(x, regs[x] * y)
  end
  def int("mul", x, y, regs) do
    regs |> Map.put(x, regs[x] * regs[y])
  end

  @doc ~S"""
  iex> Aoc.Day18.int("mod", "x", "y", %{"x" => 3, "y" => 2 })
  %{"y" => 2, "x" => 1}
  iex> Aoc.Day18.int("mod", "x", 3, %{"x" => 5})
  %{"x" => 2}
  """
  def int("mod", x, y, regs) when is_integer(y) do
    regs |> Map.put(x, rem(regs[x], y))
  end
  def int("mod", x, y, regs) do
    regs |> Map.put(x, rem(regs[x],regs[y]))
  end
  @doc ~S"""
  > Aoc.Day18.int("rcv", "x", %{"x" => 3, "snd" => 100})
  {:done, 100}
  > Aoc.Day18.int("rcv", "x", %{"x" => 0})
  {:not_done, %{"x" => 0}}
  """
  def int("rcv", x, regs) do
    case regs[x] do
      0 -> regs
      val -> 
        IO.puts "done"
        IO.inspect regs[:snd]
        []
    end
  end
  
  @doc ~S"""
  iex> Aoc.Day18.int("jgz", "x", 1, %{"x" => 3})
  {%{"x" => 3}, 1}
  iex> Aoc.Day18.int("jgz", "x", "y", %{"x" => 3, "y" => 3})
  {%{"x" => 3, "y" => 3}, 3}
  """  
  def int("jgz", x, y, regs) when is_integer(y) do
    case regs[x] != 0 do
      true -> {regs, y}
      false -> {regs, 1}
    end
  end
  def int("jgz", x, y, regs) do
    case regs[x] != 0 do
      true -> {regs, regs[y]}
      false -> {regs, 1}
    end
  end

  defmodule Program do
    defstruct registers: nil, waiting: false, queue: [], current: 0
  end

  @doc ~S"""
  iex> Aoc.Day18.part2
  :ok
  """
  def part2() do
    instructions = File.read!("./input/day18.txt") |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.map(fn(x) ->
      case String.split(x, " ") do
        [i,x,y] -> [i, convert_int(x), convert_int(y)]
        [i,x] -> [i, convert_int(x)]
      end
    end)

    program1 = %Program{ registers: init_registers() }
    program2 = %Program{ registers: init_registers() |> Map.put("p", 1)}

    :ok
    # run_instructions(instructions, init_registers(), 0)
    step(program1, program2, instructions)
  end

  def step(program1, program2, instructions) do

    if program1.waiting && program2.waiting do
      IO.puts "done"
      System.halt(0)
    end

    instruction1 = instructions |> Enum.at(program1.current)
    instruction2 = instructions |> Enum.at(program2.current)
    
    #run instructions
    # case "snd"
    # case "rec"
    # case other
    # program.registers
  end

  

end