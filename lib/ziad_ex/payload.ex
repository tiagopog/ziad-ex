defmodule ZiadEx.Payload do
  @moduledoc """
  Builds the XML payload to be used on HTTP requests to Ziad's API.
  """

  alias ZiadEx.{Credential}

  @spec build(ZiadEx.Credential.t, list) :: String.t
  def build(%Credential{} = credential, messages) do
    payload = do_build(:messages, messages)
    do_build(:document, credential, payload)
  end

  @spec build(ZiadEx.Credential.t, String.t, String.t) :: String.t
  def build(%Credential{} = credential, to, message) do
    payload = do_build(:message, to, message)
    do_build(:document, credential, payload)
  end

  @spec do_build(:document | :message, ZiadEx.Credential.t | String.t, String.t) :: String.t
  defp do_build(:document, credential, payload) do
    """
    <?xml version="1.0"?>
    <request>
      <method>sendSmsLote</method>
      #{do_build(:auth, credential)}
      #{payload}
    </request>
    """
  end

  defp do_build(:message, to, message) do
    """
    <messages>
      <recipient>
        <text>#{message}</text>
        <mobile>#{to}</mobile>
      </recipient>
    </messages>
    """
  end

  @spec do_build(:messages | :auth, list | ZiadEx.Credential.t) :: String.t
  defp do_build(:messages, messages) do
    Enum.reduce(messages, "", fn(message, result) ->
      result <> do_build(:message, message[:to], message[:message])
    end)
  end

  defp do_build(:auth, %Credential{username: username, password: password, key: key}) do
    """
    <authentication>
      <username>#{username}</username>
      <password>#{password}</password>
      <key>#{key}</key>
    </authentication>
    """
  end
end
