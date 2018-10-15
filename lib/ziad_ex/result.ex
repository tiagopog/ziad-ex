defmodule ZiadEx.Result do
  alias ZiadEx.Result

  @response_regex ~r/
    <code>(?<code>\d+)<\/code>
    <message>(?<message>.+)<\/message>
    (.+<id>(?<id>\d+)<\/id><status>(?<status>\d+)<\/status>)?/xi

  defstruct [
    :success?,
    :id,
    :message,
    :code,
    :status
  ]

  def decode({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    with matches <- Regex.named_captures(@response_regex, body),
         result  <- Map.new(matches, fn {k, v} -> {String.to_atom(k), v} end),
         result  <- Map.merge(result, %{success?: success?(result)}),
         do: Map.merge(%Result{}, result)
  end

  defp success?(%{code: code, id: id}) when code == "201" and id != "", do: true
  defp success?(_), do: false
end
