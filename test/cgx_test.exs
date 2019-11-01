defmodule CgxTest do
  use ExUnit.Case
  doctest Cgx

  test "greets the world" do
    assert Cgx.hello() == :world
  end
end
