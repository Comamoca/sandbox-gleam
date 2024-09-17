defmodule K256.MixProject do
  use Mix.Project

  @version "0.0.9"

  def project do
    [
      app: :k256,
      version: @version,
      description:
        "An wrapper around the rust elliptic-curve's k256 crate, can do Schnorr Signatures",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "k256",
      source_url: "https://github.com/comamoca/k256",
      homepage_url: "https://github.com/comamoca/k256",
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      maintainers: ["Marc Lacoursière"],
      licenses: ["UNLICENCE"],
      links: %{"GitHub" => "https://github.com/comamoca/k256"},
      files: [
        "lib",
        "native/k256_rs/.cargo",
        "native/k256_rs/src",
        "native/k256_rs/Cargo*",
        "checksum-*.exs",
        "mix.exs"
      ]
    ]
  end

  defp docs do
    [
      # The main page in the docs
      main: "K256",
      source_ref: @version,
      source_url: "https://github.com/comamoca/k256"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.29.1", only: :dev, runtime: false},
      {:rustler, "~> 0.29.1"},
      {:rustler_precompiled, "~> 0.5"},
      {:nimble_csv, "~> 1.1", only: [:dev, :test]},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
