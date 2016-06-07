defmodule EtsOwner.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(EtsOwner.Worker, []),
    ]

    opts = [strategy: :one_for_one, name: EtsOwner.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
