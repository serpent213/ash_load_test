defmodule LoadTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :load_test,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LoadTest.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:ash, "~> 3.5"},
      # {:ash, "== 3.5.4"},
      {:ash, git: "https://github.com/ash-project/ash.git", branch: "main", override: true},
      {:ash_postgres, ">= 2.4.0"},
      {:postgrex, ">= 0.0.0"},
      {:sourceror, "~> 1.7", only: [:dev, :test]}
      # {:igniter, "~> 0.5", only: [:dev, :test]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
