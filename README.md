# ZiadEx

Elixir client library to deliver short-code SMS messages via [Ziad](http://smsads.com.br/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ziad_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ziad_ex, "~> 0.1.0"}
  ]
end
```

## Usage

Single send:

```elixir
%ZiadEx.Credential{username: "foo", password: "bar", key: "baz"}
|> ZiadEx.send(to: "41999887766", message: "Join the army, they said")
```

Bulk send:

```elixir
%ZiadEx.Credential{username: "foo", password: "bar", key: "baz"}
|> ZiadEx.send([%{to: "41999887766", message: "Join the army, they said"}, %{to: "41999887766", "See the world, they said"}])
```
