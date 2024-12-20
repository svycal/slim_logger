defmodule SlimLogger.Request do
  @moduledoc """
  Compiles Phoenix request data into map for logging.

  Based on the [Logster plug](https://github.com/navinpeiris/logster/blob/master/lib/logster/plugs/logger.ex).
  """

  alias Plug.Conn

  @doc """
  Assembles a list of params for logging.
  """
  @spec to_params(Conn.t(), measurements :: :telemetry.event_measurements()) :: Keyword.t()
  def to_params(%Conn{} = conn, %{duration: duration} = _measurements) do
    []
    |> put_field(:state, conn.state)
    |> put_field(:params, get_params(conn))
    |> put_field(:ip, to_string(:inet.ntoa(conn.remote_ip)))
    |> put_field(:duration, duration |> SlimLogger.duration() |> Enum.join())
    |> put_field(:status, conn.status)
    |> put_field(:path, conn.request_path)
    |> put_field(:method, conn.method)
    |> Keyword.merge(formatted_phoenix_info(conn))
  end

  defp put_field(keyword, key, value) do
    Keyword.put(keyword, key, value)
  end

  defp formatted_phoenix_info(%{
         private: %{
           phoenix_format: format,
           phoenix_controller: controller,
           phoenix_action: action
         }
       }) do
    [
      {:format, format},
      {:controller, controller |> inspect},
      {:action, action |> Atom.to_string()}
    ]
  end

  defp formatted_phoenix_info(_), do: []

  defp get_params(%{params: _params = %Plug.Conn.Unfetched{}}), do: %{}

  defp get_params(%{params: params}) do
    params
    |> SlimLogger.filter_values()
    |> do_format_values
  end

  defp do_format_values(%_{} = params), do: params |> Map.from_struct() |> do_format_values()
  defp do_format_values(%{} = params), do: params |> Enum.into(%{}, &do_format_value/1)

  defp do_format_value({key, value}) when is_binary(value) do
    if String.valid?(value) do
      {key, value}
    else
      {key, URI.encode(value)}
    end
  end

  defp do_format_value(val), do: val
end
