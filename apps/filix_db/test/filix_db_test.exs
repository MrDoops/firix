defmodule FilixDbTest do
  use ExUnit.Case
  doctest FilixDb

  test "greets the world" do
    assert FilixDb.hello() == :world
  end
end
