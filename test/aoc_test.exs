defmodule AocTest do
  use ExUnit.Case
  alias Aoc.Day13
  alias Aoc.Day13.Wall
  doctest Aoc.Day10

  # test "scanner goes down" do
  #   wall = %Wall{scanner_pos: 1, bricks: 3, direction: :down}
  #   moved = %Wall{scanner_pos: 2, bricks: 3, direction: :down}
  #   assert Day13.move_wall_scanner(wall) == moved
  # end


  # test "scanner bounces at the bottom" do
  #   wall = %Wall{scanner_pos: 3, bricks: 3, direction: :down}
  #   moved = %Wall{scanner_pos: 2, bricks: 3, direction: :up}
  #   assert Day13.move_wall_scanner(wall) == moved
  # end

  # test "scanner bounces at the top" do
  #   wall = %Wall{scanner_pos: 1, bricks: 3, direction: :up}
  #   moved = %Wall{scanner_pos: 2, bricks: 3, direction: :down}
  #   assert Day13.move_wall_scanner(wall) == moved
  # end



end
