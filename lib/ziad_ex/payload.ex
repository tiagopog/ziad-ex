defmodule ZiadEx.Payload do
  @moduledoc """
  Documentation for ZiadEx.Payload.
  """

  alias ZiadEx.{Credential}

  def build(%Credential{} = credential, to, message) do
    payload = do_build(:message, to, message)
    do_build(:document, credential, payload)
  end

  def build(%Credential{} = credential, messages) do
    payload = do_build(:messages, messages)
    do_build(:document, credential, payload)
  end

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
