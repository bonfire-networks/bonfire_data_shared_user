defmodule Bonfire.Data.SharedUser.MixProject do
  use Mix.Project

  def project do
    [
      app: :bonfire_data_shared_user,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "Database models for shared users in the bonfire ecosystem",
      homepage_url: "https://github.com/bonfire-networks/bonfire_data_shared_user",
      source_url: "https://github.com/bonfire-networks/bonfire_data_shared_user",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" => "https://github.com/bonfire-networks/bonfire_data_shared_user",
          "Hexdocs" => "https://hexdocs.pm/bonfire_data_shared_user",
        },
      ],
      docs: [
        main: "readme",
        extras: ["README.md"],
      ],
      deps: [
        {:pointers, "~> 0.5.1"},
        {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
        {:bonfire_data_identity, git: "https://github.com/bonfire-networks/bonfire_data_identity", branch: "main"},
      ]
    ]
  end

  def application, do: [extra_applications: [:logger]]

end
