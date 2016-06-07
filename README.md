# EtsOwner

A simple GenServer that owns your ETS tables and won't die, even if you do.

## Installation

The package can be installed as:

  1. Add ets_owner to your list of dependencies in `mix.exs`:

        def deps do
          [{:ets_owner, "~> 1.0"}]
        end

  2. Ensure ets_owner is started before your application:

        def application do
          [applications: [:ets_owner]]
        end

## Usage

```elixir
iex> EtsOwner.create_table(MyTable, :set)
MyTable
...> :ets.insert(MyTable, {:my, "awesome", 'data'})
true
```

Now your code is free to make calls against `:ets`, and because your process is not
the `:ets` table owner, your data will not be lost during a crash.
