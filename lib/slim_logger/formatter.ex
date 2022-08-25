defmodule SlimLogger.Formatter do
  @moduledoc """
  A slim formatter for one-line log entries (e.g. method=GET format=html).

  Implementation based on Logster's string formatter:
  https://github.com/navinpeiris/logster/blob/3287b7d10a99e646ae90f695f1cea3b55f503adc/lib/logster/string_formatter.ex
  """

  @doc """
  Formats a map of parameters.

      iex> Formatter.format([method: :get, count: 3.0])
      [["method", "=", "get"], 32, ["count", "=", "3.000"]]
  """
  @spec format(params :: Keyword.t()) :: Keyword.t()
  def format(params) do
    params
    |> Enum.map(&format_field/1)
    |> Enum.intersperse(?\s)
  end

  defp format_field({key, value}) do
    [to_string(key), "=", format_value(value)]
  end

  defp format_value(value) when is_binary(value), do: value
  defp format_value(value) when is_float(value), do: :erlang.float_to_binary(value, decimals: 3)
  defp format_value(value) when is_atom(value) or is_integer(value), do: to_string(value)

  defp format_value(value) when is_map(value) do
    case Jason.encode(value) do
      {:ok, json} -> json
      {:error, _} -> inspect(value)
    end
  end

  defp format_value(value), do: inspect(value)
end
