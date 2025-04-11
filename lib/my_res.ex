defmodule MyRes do
  use Ash.Resource,
    otp_app: :load_test,
    domain: Main,
    # data_layer: Ash.DataLayer.Ets
    data_layer: AshPostgres.DataLayer

  postgres do
    table "my_res"
    repo(Repo)
  end

  actions do
    defaults [:read, :destroy, create: []]

    update :update do
      accept [:dummy]
    end

    update :update_with_load do
      accept [:dummy]
      change load(:full_name)
    end

    update :update_with_ci_load do
      accept [:dummy]
      change load([:ci_full_name, :ci2string_full_name])
      change debug_log()
    end

    update :update_with_ci_load_sql do
      accept [:dummy]
      change load(:ci_full_name_sql)
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
    calculate :ci_full_name_sql, :ci_string, expr(fragment("name1_ci || ' ' || name2_ci"))
  end
end
