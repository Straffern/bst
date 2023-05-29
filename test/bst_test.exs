defmodule BSTTest do
  use ExUnit.Case
  doctest BST

  describe "new/2" do
    test "create new empty binary search tree, with comparator" do
      assert %BST{root: nil} = BST.new([], fn a, b -> a <= b end)
    end

    test "create tree with a root node when given one element" do
      assert %BST{root: %BST.Node{value: 1, left: nil, right: nil}} = BST.new([1])
    end

    test "create tree with a root node and a left node when given two elements" do
      assert %BST{
        root: %BST.Node{
          value: 2,
          left: %BST.Node{
            value: 1,
            left: nil,
            right: nil},
          right: nil}
        } = BST.new([2, 1])
    end

    test "create tree with a root node and a right node when given two elements" do
      assert %BST{root: %BST.Node{value: 1, left: nil, right: %BST.Node{value: 2, left: nil, right: nil}}} = BST.new([1, 2])
    end
  end


end
