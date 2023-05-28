defmodule BsTreeTest do
  use ExUnit.Case
  doctest BsTree

  test "greets the world" do
    assert BsTree.hello() == :world
  end
  test "error" do
    assert BsTree.hello() == :wrong
  end

end
