defmodule AsteriskTest do
  use ExUnit.Case
  doctest Asterisk

  test "greets the world" do
    assert Asterisk.hello() == :world
  end
end
