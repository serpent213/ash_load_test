defmodule LoadTestTest do
  use ExUnit.Case
  doctest LoadTest

  setup_all do
    {:ok, seed: Ash.Seed.seed!(MyRes, %{name1: "a", name2: "b", name1_ci: "c", name2_ci: "d"})}
  end

  describe ":string" do
    test "for_update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :full_name)
        |> Ash.update!()

      refute is_struct(updated.full_name, Ash.NotLoaded)
      assert updated.full_name == "a b"
    end

    test "update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!(load: :full_name)

      refute is_struct(updated.full_name, Ash.NotLoaded)
      assert updated.full_name == "a b"
    end

    test "load in action", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update_with_load, %{dummy: "foo"})
        |> Ash.update!()

      refute is_struct(updated.full_name, Ash.NotLoaded)
      assert updated.full_name == "a b"
    end

    test "explicit Ash.load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!()
        |> Ash.load!(:full_name)

      refute is_struct(updated.full_name, Ash.NotLoaded)
      assert updated.full_name == "a b"
    end
  end

  describe ":ci_string" do
    test "for_update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :ci_full_name)
        |> Ash.update!()

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!(load: :ci_full_name)

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "load in action", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update_with_ci_load, %{dummy: "foo"})
        |> Ash.update!()

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "explicit Ash.load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!()
        |> Ash.load!(:ci_full_name)

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end
  end

  describe ":ci_string w/SQL" do
    @describetag :skip
    test "for_update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :ci_full_name_sql)
        |> Ash.update!()

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!(load: :ci_full_name_sql)

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "load in action", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update_with_ci_load_sql, %{dummy: "foo"})
        |> Ash.update!()

      refute is_struct(updated.full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end

    test "explicit Ash.load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!()
        |> Ash.load!(:ci_full_name_sql)

      refute is_struct(updated.ci_full_name, Ash.NotLoaded)
      assert updated.ci_full_name.string == "c d"
    end
  end

  describe ":ci2string to :string" do
    @describetag :skip
    test "for_update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :ci2string_full_name)
        |> Ash.update!()

      refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
      assert updated.ci2string_full_name == "c d"
    end

    test "update with load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!(load: :ci2string_full_name)

      refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
      assert updated.ci2string_full_name == "c d"
    end

    test "explicit Ash.load", %{seed: seed} do
      updated =
        Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
        |> Ash.update!()
        |> Ash.load!(:ci2string_full_name)

      refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
      assert updated.ci2string_full_name == "c d"
    end
  end
end
