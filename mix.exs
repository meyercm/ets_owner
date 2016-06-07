defmodule EtsOwner.Mixfile do
  use Mix.Project

  def project do
    [app: :ets_owner,
     version: "1.0.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {EtsOwner.App, []}]
  end

  defp deps do
    []
  end
end
