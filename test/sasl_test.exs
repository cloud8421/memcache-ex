defmodule SaslTest do
  use ExUnit.Case
  alias Memcache.Connection

  test "supports authentication" do
    { :ok, pid } = Connection.start_link([ hostname: "localhost", port: 11212 ])
    { :ok, :plain } = Connection.execute(pid, :AUTH_NEGOTIATION, [])
    { :ok, :authenticated } = Connection.execute(pid, :AUTH_REQUEST, ["memcache", "dragonfly"])
    { :error, "Invalid authentication credentials" } = Connection.execute(pid, :AUTH_REQUEST, ["memcache", "wrong-password"])
  end
end
