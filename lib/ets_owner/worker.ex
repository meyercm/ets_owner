defmodule EtsOwner.Worker do
  use GenServer
  require Logger
  ##############################
  # API
  ##############################

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def create_table(table_name, type, options \\ []) do
    GenServer.call(__MODULE__, {:create_table, table_name, type, options})
  end

  defmodule State do
    defstruct []
  end

  ##############################
  # GenServer Callbacks
  ##############################

  def init([]) do
    {:ok, %State{}}
  end

  def handle_call( {:create_table, table_name, type, options}, _from, state) do
    try do
      if :ets.info(table_name) == :undefined do
        :ets.new(table_name, [:public, :named_table, type] ++ options)
      end
    rescue _ -> :ok
    end
    {:reply, table_name, state}
  end
  def handle_call(msg, _from, state) do
    Logger.error("EtsOwner.Worker rx unexpected call: #{msg}")
    {:reply, :ok, state}
  end
  def handle_cast(msg, state) do
    Logger.error("EtsOwner.Worker rx unexpected cast: #{msg}")
    {:noreply, state}
  end
  def handle_info(msg, state) do
    Logger.error("EtsOwner.Worker rx unexpected info: #{msg}")
    {:noreply, state}
  end
  ##############
  # Internal
  ##############

end
