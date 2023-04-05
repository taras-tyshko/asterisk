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
    spawn(fn -> send(current, {self(), func.()}) end)

    receive do
      {:selector, number, name} when is_integer(number) ->
        name
      name ->
        name
      _ ->
        IO.puts(:stderr, "Unexpected message received")
    after
      timeout ->
        IO.puts(:stderr, "No message in #{timeout} seconds")
    end

  end
end
