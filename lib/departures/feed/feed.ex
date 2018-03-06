defmodule Departures.Feed do
  @moduledoc """
  The Feed context.
  """

  import Ecto.Query, warn: false
  alias Departures.Repo

  alias Departures.Feed.Train

  @doc """
  Update train data from departure board feed
  
  ## Example
    Departures.Feed.update("http://developer.mbta.com/lib/gtrtfs/Departures.csv")
  """
  def update(url \\ "http://developer.mbta.com/lib/gtrtfs/Departures.csv") do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        store(:csv,body)
        {:ok, "Departures.Feed.update completed"}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Departures.Feed.update failed: " <> url <> "Not found :("}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Departures.Feed.update failed: " <> reason}
    end
  end

  def store(:csv,data) do
    String.splitter(data, "\n")
    |> Enum.filter(fn(x) -> 7 < String.length(x) end)
    |> CSV.decode!(headers: true)
    |> Enum.each(fn(x) -> create_train(x) end)
  end 

@doc """
  Truncate train data from departure board feed
  
  ## Example
    Departures.Feed.clear()
  """
  def clear() do
    list_trains()
    |> Enum.each(fn(x) -> delete_train(%Train{id: x.id}) end)
  end

  @doc """
  Returns the list of trains.

  ## Examples

      iex> list_trains()
      [%Train{}, ...]

  """
  def list_trains do
    Repo.all(Train)
  end
  def list_trains(origin) do
    Enum.filter(list_trains(), fn(x) -> Map.from_struct(x)."Origin" == origin end)
  end

  @doc """
  Gets a single train.

  Raises `Ecto.NoResultsError` if the Train does not exist.

  ## Examples

      iex> get_train!(123)
      %Train{}

      iex> get_train!(456)
      ** (Ecto.NoResultsError)

  """
  def get_train!(id), do: Repo.get!(Train, id)

  @doc """
  Creates a train.

  ## Examples

      iex> create_train(%{field: value})
      {:ok, %Train{}}

      iex> create_train(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_train(attrs \\ %{}) do
    %Train{}
    |> Train.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a train.

  ## Examples

      iex> update_train(train, %{field: new_value})
      {:ok, %Train{}}

      iex> update_train(train, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_train(%Train{} = train, attrs) do
    train
    |> Train.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Train.

  ## Examples

      iex> delete_train(train)
      {:ok, %Train{}}

      iex> delete_train(train)
      {:error, %Ecto.Changeset{}}

  """
  def delete_train(%Train{} = train) do
    Repo.delete(train)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking train changes.

  ## Examples

      iex> change_train(train)
      %Ecto.Changeset{source: %Train{}}

  """
  def change_train(%Train{} = train) do
    Train.changeset(train, %{})
  end
end
