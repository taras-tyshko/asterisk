defmodule Asterisk do
  @moduledoc """
  Documentation for Asterisk.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Asterisk.hello()
      :world

  """
#  @spec with_timeout(timeout :: integer())
  def with_timeout(timeout, func) do
    current = self()
    pid = spawn(fn -> send(current, {self(), func.()}) end)

    receive do
      {^pid, result} ->
        {:ok, result}

      _ ->
        IO.puts(:stderr, "Unexpected message received")
    after
      timeout ->
        IO.puts(:stderr, "No message in #{timeout} seconds")
        {:error, :timeout}
    end

  end
end
