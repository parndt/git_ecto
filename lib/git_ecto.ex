defmodule GitEcto do
  use Application

  def start(_type, _args) do
    GitEcto.Supervisor.start_link()
  end
end
