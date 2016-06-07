defmodule EtsOwner do
  @type table :: :bag | :duplicate_bag | :set | :ordered_set

  @doc """
  Creates an ets table if it doesn't already exist, noop if it does.

  ## Examples:
    iex> EtsOwner.create_table(MyTable, :set)
    MyTable
  """
  @spec create_table(atom, table, [any]) :: atom
  def create_table(table_name, type, options \\ []) do
    EtsOwner.Worker.create_table(table_name, type, options)
  end

end
