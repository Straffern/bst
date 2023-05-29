defmodule BST do
  @moduledoc """
  A binary search tree, with comparator function and thus supporting any type of value.
  """

  alias BST.Node

  defstruct [:root, :comparator]


  @typedoc "The data structure for the value key for each node in the tree."
  @type element :: term()

  @typedoc """
  Function used to determine whether to place new nodes as a left or right subtree.

  Returns
  - 0 if a == b
  - negative integer if a < b
  - positive integer if a > b
  """
  @type comparator :: (element(), element() -> integer())

  @type tree :: %__MODULE__{
    root: Node.t() | nil,
    comparator: comparator()
  }

  @doc """
  Creates a new `tree`.

  ## Examples

      iex> tree = BST.new([0])
      iex> tree.root
      %BST.Node{value: 0, left: nil, right: nil}
      iex> tree = BST.new([0, 1, 2])
      iex> tree.root
      %BST.Node{
        value: 0,
        left: nil,
        right: %BST.Node{value: 1, left: nil, right: %BST.Node{value: 2, left: nil, right: nil}}
      }
      iex> tree = BST.new([%{id: 1, name: "Alice"}, %{id: 2, name: "Bob"}], fn a, b -> a.id - b.id end)
      iex> tree.root
      %BST.Node{
        value: %{id: 1, name: "Alice"},
        left: nil,
        right: %BST.Node{value: %{id: 2, name: "Bob"}, left: nil, right: nil}
      }
  """
  @spec new([element()], comparator()) :: tree()
  def new(elements \\ [], comparator \\ &(&1 - &2)) when
    is_list(elements) and is_function(comparator) do

      tree = %__MODULE__{comparator: comparator}
    Enum.reduce(elements, tree, fn element, tree ->
      insert(tree, element)
    end)
  end


  @doc """
  Adds a node to a tree.

  If there is duplicate value, the `fun` function will be called with the existing value and the new value.
  """
  @spec insert(tree(), element(), (element(), element() -> element())) :: tree()
  def insert(tree, value, fun \\ fn _a, b -> b end) do
    %__MODULE__{tree | root: insert_node(tree.root, value, tree.comparator, fun)}
  end


  defp insert_node(nil, element, _comparator, _fun), do: %Node{value: element}

  defp insert_node(%Node{value: elem1, left: left, right: right} = node, elem2, comparator, fun) do
    case compare(elem1, elem2, comparator) do
      :eq -> %Node{node | value: fun.(elem1, elem1)}
      :lt -> %Node{node | left: insert_node(left, elem2, comparator, fun)}
      :gt -> %Node{node | right: insert_node(right, elem2, comparator, fun)}
    end
  end







  defp compare(a, b, comparator) do
    val = comparator.(a, b)

    cond do
      val == 0 -> :eq
      val < 0 -> :lt
      val > 0 -> :gt
    end
  end
end
