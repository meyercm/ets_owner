defmodule EtsOwner.Mixfile do
  use Mix.Project

  def project do
    [app: :ets_owner,
     version: "1.0.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps,
   ]
  end

  def application do
    [applications: [:logger],
     mod: {EtsOwner.App, []}]
  end

  defp deps do
    []
  end

  defp description do
    """
    A simple GenServer that owns your ETS tables and won't die, even if you do.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :ets_owner,
     files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Chris Meyer"],
      licenses: ["MIT"],
      links: %{ "GitHub": "https://github.com/meyercm/ets_owner" }]
  end
end
