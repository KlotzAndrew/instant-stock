defmodule Commands.FetchQuotes do
  @batchlimit_quotes 400

  @yahoo_api_start "https://query.yahooapis.com/"
  @yahoo_api_query "v1/public/yql?q=SELECT * FROM yahoo.finance.quotes W" <>
                   "HERE symbol IN (yahoo_tickers)"
  @yahoo_api_end "&format=json&diagnostics=true&env=store%3A%2F%2Fdatata" <>
                 "bles.org%2Falltableswithkeys&callback="

  def fetch(tickers, api_client \\ HTTPoison) do
    formatted_tickers = format_tickers(tickers)
    quote_data = call_api(formatted_tickers, api_client)

    format_quote_data(quote_data)
  end

  defp call_api(tickers, api_client) do
    url = format_api_url(tickers)
    response = api_client.get! url
    response.body
  end

  defp format_api_url(tickers) do
    query_body = build_yql_body(tickers)
    @yahoo_api_start <> query_body <> @yahoo_api_end
  end

  defp build_yql_body(tickers) do
    url = String.replace(@yahoo_api_query, "yahoo_tickers", tickers)
    URI.encode(url)
  end

  defp format_quote_data(data) do
    quote_data = parse_quote_data(data)
    List.wrap(quote_data)
  end

  defp parse_quote_data(data) do
    json = Poison.decode!(data)
    json["query"]["results"]["quote"]
  end

  defp format_tickers(tickers) do
    formatted = Enum.map(tickers, fn(x) -> "'" <> x <> "'" end)
    Enum.join(formatted, ", ")
  end
end
