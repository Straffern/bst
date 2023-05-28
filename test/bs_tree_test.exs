defmodule BsTreeTest do
  use ExUnit.Case
  doctest BsTree

  test "greets the world" do
    assert BsTree.hello() == :world
  end

  describe "new/2" do
    test "create new empty binary search tree, with comparator" do
      assert %BsTree{root: nil} = BsTree.new([], fn a, b -> a <= b end)
    end

    test "create tree with a root node when given one element" do
      assert %BsTree{root: %BsTree.Node{value: 1, left: nil, right: nil}} = BsTree.new([1])
    end

    test "create tree with a root node and a left node when given two elements" do
      assert %BsTree{root: %BsTree.Node{value: 2, left: %BsTree.Node{value: 1, left: nil, right: nil}, right: nil}} = BsTree.new([2, 1])
    end

    test "create tree with a root node and a right node when given two elements" do
      assert %BsTree{root: %BsTree.Node{value: 1, left: nil, right: %BsTree.Node{value: 2, left: nil, right: nil}}} = BsTree.new([1, 2])
    end
  end


end
