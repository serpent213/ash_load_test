defmodule Main do
  use Ash.Domain,
    otp_app: :load_test

  resources do
    resource MyRes
  end
end
