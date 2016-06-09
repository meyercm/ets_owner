# EtsOwner

A simple GenServer that owns your ETS tables and won't die, even if you do.


## Usage

```elixir
iex> EtsOwner.create_table(MyTable, :set)
MyTable
...> :ets.insert(MyTable, {:my, "awesome", 'data'})
true
```

Now your code is free to make calls against `:ets`, and because your process is
not the `:ets` table owner, your data will not be lost during a crash.

## Why?

How about a simple example:

First, we create two `:ets` tables, and insert a record in each:

```
Interactive Elixir (1.2.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> :ets.new(Unsafe, [:public, :named_table, :set])
Unsafe
iex(2)> :ets.insert(Unsafe, {:about, 2, "lose this"})
true
iex(3)> EtsOwner.create_table(Safe, :set)
Safe
iex(4)> :ets.insert(Safe, {:not, "going anywhere"})
true
```

Next, we crash the shell:

```
iex(5)> Process.exit(self, :kill)
** (EXIT from #PID<0.146.0>) killed
```

Now, let's see what we've got. Elixir being what it is, the shell has restarted;
the `Safe` table is still in place, and so is it's data:

```
Interactive Elixir (1.2.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> :ets.info(Safe)
[read_concurrency: false, write_concurrency: false, compressed: false,
 memory: 318, owner: #PID<0.134.0>, heir: :none, name: Safe, size: 1,
 node: :nonode@nohost, named_table: true, type: :set, keypos: 1,
 protection: :public]
```

Lets see how `Unsafe` is doing: It and the data are gone, because the owning
process died:

```
iex(2)> :ets.info(Unsafe)
:undefined
iex(3)> :ets.tab2list(Safe)
[not: "going anywhere"]
```

## API

#### Create a table `:create_table/3`

`create_table(name, type, opts \\ [])` Creates a new table if the table does not
already exist. Has no effect if the table is already present.

Parameters:
- `name` name for the table
- `type` which type of `:ets` table (`:set`, `:ordered_set`, `:bag`,
`:duplicate_bag`) to create
- `opts` additional options to pass to `:ets.new/3`. Already includes `:public`
and `:named_table`

## Installation

The package can be installed as:

1. Add ets_owner to your list of dependencies in `mix.exs`:
  ```elixir
  def deps do
    [{:ets_owner, "~> 1.0"}]
  end
  ```

2. Ensure ets_owner is started before your application:
  ```elixir
  def application do
    [applications: [:ets_owner]]
  end
  ```
