defmodule ZiadEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :ziad_ex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :project, plt_add_apps: [:httpoison]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:dialyxir, "1.0.0-rc.3", only: [:dev], runtime: false}
    ]
  end
end
