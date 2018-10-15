defmodule ZiadEx do
  @moduledoc """
  Documentation for ZiadEx.
  """

  @base_url "https://www.plataformadesms.com.br/sms/public/api/rest"
  @content_type {"Content-Type", "application/xml"}

  alias ZiadEx.{Credential,Payload,Result}

  @doc """
  TODO

  ## Examples

      iex> ZiadEx.send()
      :world

  """
  def send(%Credential{} = credential, to: to, message: message) do
    payload = Payload.build(credential, to, message)
    HTTPoison.post(@base_url, payload, [@content_type])
    |> Result.parse
  end

  def send(%Credential{} = credential, messages) when is_list(messages) do
    payload = Payload.build(credential, messages)
    HTTPoison.post(@base_url, payload, [@content_type])
    |> Result.parse
  end
end
