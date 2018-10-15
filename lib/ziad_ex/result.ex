defmodule ZiadEx.Result do
  @moduledoc """
  Deals with responses from Ziad's API.
  """

  alias ZiadEx.Result

  @response_regex ~r/
    <code>(?<code>\d+)<\/code>
    <message>(?<message>.+)<\/message>
    (.*<id>(?<id>\d+)<\/id><status>(?<status>\d+)<\/status>)?/xi

  defstruct [
    :success?,
    :id,
    :message,
    :code,
    :status
  ]

  @typedoc "Ziad result struct"
  @type t :: %__MODULE__{
    success?: nil | boolean,
    id: nil | String.t,
    message: nil | String.t,
    code: nil | String.t,
    status: nil | String.t
  }

  @doc """
  Takes data from Ziad's XML response to turn into a `%Ziad.Result{}` struct.

  ## Examples

      iex> body = "<code>201</code><message>Foobar</message><id>123</id><status>100</status>"
      ...> ZiadEx.Result.parse({:ok, %HTTPoison.Response{body: body}})
      %ZiadEx.Result{code: "201", id: "123", message: "Foobar", status: "100", success?: true}

  """
  @spec parse({:ok, HTTPoison.Response.t}) :: ZiadEx.Result.t
  def parse({:ok, %HTTPoison.Response{body: body}}) do
    with matches <- Regex.named_captures(@response_regex, body),
         result  <- Map.new(matches, fn {k, v} -> {String.to_atom(k), v} end),
         result  <- Map.merge(result, %{success?: success?(result)}),
         do: Map.merge(%Result{}, result)
  end

  @doc """
  Check whether the response was successful by its returning "code" and "id".
  """
  @spec success?(map) :: boolean
  def success?(%{code: code, id: id}) when code == "201" and id != "", do: true
  def success?(_), do: false
end
