# SlimLogger

A logger implementation to replace the default `Phoenix.Logger`.

This implemention is a fork of `Phoenix.Logger` designed to produce slimmer single-line log entries for requests, similar to [Logster](https://hexdocs.pm/logster/readme.html) or Lograge. We decided to use the default Phoenix logger as a base implementation, since Logster is not very actively maintained (as of August 2022) and we want to keep the benefits of conditionally disabling logs (via `Plug.Telemetry` config) and outputting the default debug logs in development mode (which we would lose by switching wholesale over to Logster).

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
