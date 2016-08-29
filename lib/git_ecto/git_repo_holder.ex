defmodule GitEcto.GitRepoHolder do
  use GenServer

  def start_link(git_repo) do
    GenServer.start_link(__MODULE__, git_repo, name: __MODULE__)
  end

  def repo do
    GenServer.call(__MODULE__, :repo)
  end

  def handle_call(:repo, _from, git_repo) do
    {:reply, git_repo, git_repo}
  end

end
