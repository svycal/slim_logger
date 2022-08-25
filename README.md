# SlimLogger

A logger implementation to replace the default `Phoenix.Logger`.

This is a fork of `Phoenix.Logger` designed to produce slimmer single-line log entries for requests.

## Installation

The package can be installed by adding `slim_logger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:slim_logger, git: "https://github.com/svycal/slim_logger.git", ref: "main"}
  ]
end
```

You'll want to disable the default Phoenix logger in config:

```elixir
# config/config.exs

# Disable the default `Phoenix.Logger` so we can use `SlimLogger` instead.
config :phoenix, :logger, false
```

Then, in your application file, run the install command:

```elixir
# lib/my_app/application.ex

defmodule MyApp.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # ...
    ]

    # Install the slim logger
    SlimLogger.install()

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```
