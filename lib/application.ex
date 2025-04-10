defmodule LoadTest.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Repo,
    ]

    opts = [strategy: :one_for_one, name: LoadTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

