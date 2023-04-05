defmodule Poller do
  use GenServer

  # [
  #   {{TheCache, :cleanse, [:auto]}, :timer.minutes(10)},
  #   {{Heartbeat, :ping, []}, :timer.seconds(10)},
  #   {{...}, 1000}
  # ]

  #   {{TheCache, :cleanse, [:auto]}, :timer.minutes(10)}

  def start_link(init) do
    GenServer.start_link(__MODULE__, init)
  end

  @impl true
  def init(state) do
    schedule_work(state)
    {:ok, state}
  end

  @impl true
  def handle_info(:next_job, state) do
    schedule_work(state)

    {:noreply, state}
  end

  defp schedule_work({{module, func, args}, interval} = state) do
    apply(module, func, args)
    Process.send_after(self(), :next_job, interval)
  end
end
