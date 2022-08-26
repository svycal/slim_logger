# SlimLogger

A logger implementation to replace the default `Phoenix.Logger`.

This is a fork of `Phoenix.Logger` designed to produce slimmer, single-line log entries for requests. At the moment, only standard request logs have been slimmed down.

## Installation

The package can be installed by adding `slim_logger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:slim_logger, "~> 0.1"}
  ]
end
```

To get started, disable the default Phoenix logger in config:

```elixir
# config/config.exs

# Disable the default `Phoenix.Logger` so we can use `SlimLogger` instead.
config :phoenix, :logger, false
```

Then, in your application file, call the install function:

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
