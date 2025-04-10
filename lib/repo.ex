defmodule Repo do
  use AshPostgres.Repo, otp_app: :load_test

  def installed_extensions do
    ["uuid-ossp", "citext", "ash-functions"]
  end
end
