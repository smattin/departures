defmodule Departures.FeedTest do
  use Departures.DataCase

  alias Departures.Feed

  describe "trains" do
    alias Departures.Feed.Train

    @valid_attrs %{destination: "some destination", lateness: 42, origin: "some origin", scheduled: 42, status: "some status", track: 42, trip: 42, ts: 42}
    @update_attrs %{destination: "some updated destination", lateness: 43, origin: "some updated origin", scheduled: 43, status: "some updated status", track: 43, trip: 43, ts: 43}
    @invalid_attrs %{destination: nil, lateness: nil, origin: nil, scheduled: nil, status: nil, track: nil, trip: nil, ts: nil}

    def train_fixture(attrs \\ %{}) do
      {:ok, train} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feed.create_train()

      train
    end

    test "list_trains/0 returns all trains" do
      train = train_fixture()
      assert Feed.list_trains() == [train]
    end

    test "get_train!/1 returns the train with given id" do
      train = train_fixture()
      assert Feed.get_train!(train.id) == train
    end

    test "create_train/1 with valid data creates a train" do
      assert {:ok, %Train{} = train} = Feed.create_train(@valid_attrs)
      assert train.destination == "some destination"
      assert train.lateness == 42
      assert train.origin == "some origin"
      assert train.scheduled == 42
      assert train.status == "some status"
      assert train.track == 42
      assert train.trip == 42
      assert train.ts == 42
    end

    test "create_train/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_train(@invalid_attrs)
    end

    test "update_train/2 with valid data updates the train" do
      train = train_fixture()
      assert {:ok, train} = Feed.update_train(train, @update_attrs)
      assert %Train{} = train
      assert train.destination == "some updated destination"
      assert train.lateness == 43
      assert train.origin == "some updated origin"
      assert train.scheduled == 43
      assert train.status == "some updated status"
      assert train.track == 43
      assert train.trip == 43
      assert train.ts == 43
    end

    test "update_train/2 with invalid data returns error changeset" do
      train = train_fixture()
      assert {:error, %Ecto.Changeset{}} = Feed.update_train(train, @invalid_attrs)
      assert train == Feed.get_train!(train.id)
    end

    test "delete_train/1 deletes the train" do
      train = train_fixture()
      assert {:ok, %Train{}} = Feed.delete_train(train)
      assert_raise Ecto.NoResultsError, fn -> Feed.get_train!(train.id) end
    end

    test "change_train/1 returns a train changeset" do
      train = train_fixture()
      assert %Ecto.Changeset{} = Feed.change_train(train)
    end
  end
end
