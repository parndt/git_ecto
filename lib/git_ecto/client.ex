defmodule GitEcto.Client do
  use GenServer

  def start_link(repo) do
    GenServer.start_link(__MODULE__, repo, name: __MODULE__)
  end

  def repo do
    GenServer.call(__MODULE__, :repo)
  end

  def handle_call(:repo, _from, repo) do
    {:reply, repo, repo}
  end

end
