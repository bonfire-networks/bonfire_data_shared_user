Code.eval_file("mess.exs", (if File.exists?("../../lib/mix/mess.exs"), do: "../../lib/mix/"))

defmodule Bonfire.Data.SharedUser.MixProject do
  use Mix.Project

  def project do
    if File.exists?("../../.is_umbrella.exs") do
      [
        build_path: "../../_build",
        config_path: "../../config/config.exs",
        deps_path: "../../deps",
        lockfile: "../../mix.lock"
      ]
    else
      []
    end
    ++
    [
      app: :bonfire_data_shared_user,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "Database models for shared users in the bonfire ecosystem",
      homepage_url:
        "https://github.com/bonfire-networks/bonfire_data_shared_user",
      source_url:
        "https://github.com/bonfire-networks/bonfire_data_shared_user",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" =>
            "https://github.com/bonfire-networks/bonfire_data_shared_user",
          "Hexdocs" => "https://hexdocs.pm/bonfire_data_shared_user"
        }
      ],
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      deps: Mess.deps [
        {:pointers, "~> 0.5.1"},
        {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
        {:bonfire_data_identity,
         git: "https://github.com/bonfire-networks/bonfire_data_identity",
         branch: "main"}
      ]
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
