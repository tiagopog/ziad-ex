defmodule ZiadEx.Credential do
  @moduledoc """
  Struct with the required credentials to authenticate on Ziad's API.
  """

  defstruct [:username, :password, :key]

  @typedoc "Ziad's credentials"
  @type t :: %__MODULE__{
    username: String.t,
    password: String.t,
    key: String.t
  }
end
