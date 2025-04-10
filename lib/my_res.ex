defmodule MyRes do
  use Ash.Resource,
    otp_app: :load_test,
    domain: Main,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:read, :destroy, create: []]

    update :update do
      accept [:dummy]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name1, :string do
      allow_nil? false
    end

    attribute :name2, :string do
      allow_nil? false
    end

    attribute :name1_ci, :ci_string do
      allow_nil? false
    end

    attribute :name2_ci, :ci_string do
      allow_nil? false
    end

    attribute :dummy, :ci_string
  end

  calculations do
    calculate :full_name, :string, expr(name1 <> " " <> name2)
    calculate :ci_full_name, :ci_string, expr(name1_ci <> " " <> name2_ci)
    calculate :ci2string_full_name, :string, expr(name1_ci <> " " <> name2_ci)
  end
end
