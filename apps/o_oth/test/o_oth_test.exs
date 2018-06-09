defmodule OOthTest do
  use ExUnit.Case
  doctest OOth

  test "greets the world" do
    assert OOth.hello() == :world
  end
end
