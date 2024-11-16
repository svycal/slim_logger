defmodule SlimLogger.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :slim_logger,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Slim Logger",
      source_url: "https://github.com/svycal/slim_logger",
      homepage_url: "https://github.com/svycal/slim_logger",
      docs: docs(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.0"},
      {:telemetry, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md",
        "LICENSE.md"
      ]
    ]
  end

  defp description do
    "A single-line logger implementation to replace the default Phoenix logger."
  end

  defp package do
    [
      maintainers: ["Derrick Reimer"],
      licenses: ["MIT"],
      links: links()
    ]
  end

  def links do
    %{
      "GitHub" => "https://github.com/svycal/slim_logger",
      "Changelog" => "https://github.com/svycal/slim_logger/blob/v#{@version}/CHANGELOG.md",
      "Readme" => "https://github.com/svycal/slim_logger/blob/v#{@version}/README.md"
    }
  end
end
