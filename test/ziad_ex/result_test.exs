defmodule ZiadEx.ResultTest do
  use ExUnit.Case, async: true

  alias ZiadEx.Result

  doctest ZiadEx.Result

  test "parses a successful response" do
    body = "<code>201</code><message>Foobar</message><id>123</id><status>100</status>"
    expected = %ZiadEx.Result{code: "201", id: "123", message: "Foobar", status: "100", success?: true}
    assert Result.parse({:ok, %HTTPoison.Response{body: body}}) == expected
  end

  test "fails parsing a response in a non-expected format" do
    assert Result.parse(:error) == {:error, "Error while trying to parse the response"}
  end

  test "succeeds with an expected code and a present id" do
    assert Result.success?(%{code: "201", id: "123"}) == true
  end

  test "fails with an expected code and a blank id" do
    assert Result.success?(%{code: "201"}) == false
  end

  test "fails with an unexpected code" do
    assert Result.success?(%{code: "400"}) == false
  end
end
