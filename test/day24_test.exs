defmodule Aoc.Day24Test do
  use ExUnit.Case
  alias Aoc.Day24

  test "testing" do

    comp = Day24.read_input()

    assert Day24.possible_next_bridges([{0,1}], comp) == [[{10, 1}, {0, 1}]]

  end

end
