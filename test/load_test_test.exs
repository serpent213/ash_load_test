defmodule LoadTestTest do
  use ExUnit.Case
  doctest LoadTest

  setup_all do
    {:ok, seed: Ash.Seed.seed!(MyRes, %{name1: "a", name2: "b", ci_name1: "c", ci_name2: "d"})}
  end

  # string
  test "string: for_update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :full_name)
      |> Ash.update!()

    refute is_struct(updated.full_name, Ash.NotLoaded)
    assert updated.full_name == "a b"
  end

  test "string: update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!(load: :full_name)

    refute is_struct(updated.full_name, Ash.NotLoaded)
    assert updated.full_name == "a b"
  end

  test "string: explicit Ash.load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!()
      |> Ash.load!(:full_name)

    refute is_struct(updated.full_name, Ash.NotLoaded)
    assert updated.full_name == "a b"
  end

  # ci_string
  @tag :skip
  test "ci_string: for_update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :ci_full_name)
      |> Ash.update!()

    refute is_struct(updated.ci_full_name, Ash.NotLoaded)
    assert updated.ci_full_name.string == "c d"
  end

  @tag :skip
  test "ci_string: update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!(load: :ci_full_name)

    refute is_struct(updated.ci_full_name, Ash.NotLoaded)
    assert updated.ci_full_name.string == "c d"
  end

  @tag :skip
  test "ci_string: explicit Ash.load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!()
      |> Ash.load!(:ci_full_name)

    refute is_struct(updated.ci_full_name, Ash.NotLoaded)
    assert updated.ci_full_name.string == "c d"
  end

  # ci2string
  @tag :skip
  test "ci_string2string: for_update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"}, load: :ci2string_full_name)
      |> Ash.update!()

    refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
    assert updated.ci2string_full_name == "c d"
  end

  @tag :skip
  test "ci_string2string: update with load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!(load: :ci2string_full_name)

    refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
    assert updated.ci2string_full_name == "c d"
  end

  @tag :skip
  test "ci_string2string: explicit Ash.load", %{seed: seed} do
    updated =
      Ash.Changeset.for_update(seed, :update, %{dummy: "foo"})
      |> Ash.update!()
      |> Ash.load!(:ci2string_full_name)

    refute is_struct(updated.ci2string_full_name, Ash.NotLoaded)
    assert updated.ci2string_full_name == "c d"
  end
end
