defmodule BST.Node do
  @moduledoc """
  The data structure for each node in the tree.
  """
  defstruct [:value, :left, :right]

  @type t :: %__MODULE__{
    value: BST.element(),
    left: t | nil,
    right: t | nil
  }
end
