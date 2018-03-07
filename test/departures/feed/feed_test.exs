defmodule Departures.FeedTest do
  use Departures.DataCase

  alias Departures.Feed

  describe "trains" do
    alias Departures.Feed.Train

    @valid_attrs %{Destination: "some destination", Lateness: 42, Origin: "some origin", ScheduledTime: 42, Status: "some status", Track: 42, Trip: 42, TimeStamp: 42}
    @update_attrs %{Destination: "some updated destination", Lateness: 43, Origin: "some updated origin", ScheduledTime: 43, Status: "some updated status", Track: 43, Trip: 43, TimeStamp: 43}
    @invalid_attrs %{Destination: nil, Lateness: nil, Origin: nil, ScheduledTime: nil, Status: nil, Track: nil, Trip: nil, TimeStamp: nil}

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
      assert train."Destination" == "some destination"
      assert train."Lateness" == 42
      assert train."Origin" == "some origin"
      assert train."ScheduledTime" == 42
      assert train."Status" == "some status"
      assert train."Track" == 42
      assert train."Trip" == 42
      assert train."TimeStamp" == 42
    end

    test "create_train/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feed.create_train(@invalid_attrs)
    end

    test "update_train/2 with valid data updates the train" do
      train = train_fixture()
      assert {:ok, train} = Feed.update_train(train, @update_attrs)
      assert %Train{} = train
      assert train."Destination" == "some updated destination"
      assert train."Lateness" == 43
      assert train."Origin" == "some updated origin"
      assert train."ScheduledTime" == 43
      assert train."Status" == "some updated status"
      assert train."Track" == 43
      assert train."Trip" == 43
      assert train."TimeStamp" == 43
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
