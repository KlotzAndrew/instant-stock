defmodule PhoenixApi.MinuteBarController do
  use PhoenixApi.Web, :controller

  alias PhoenixApi.MinuteBar

  def index(conn, _params) do
    minute_bars = Repo.all(MinuteBar)
    render(conn, "index.json", data: minute_bars)
  end

  def create(conn, %{"minute_bar" => minute_bar_params}) do
    changeset = MinuteBar.changeset(%MinuteBar{}, minute_bar_params)

    case Repo.insert(changeset) do
      {:ok, minute_bar} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", minute_bar_path(conn, :show, minute_bar))
        |> render("show.json", data: minute_bar)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    minute_bar = Repo.get!(MinuteBar, id)
    render(conn, "show.json", data: minute_bar)
  end

  def update(conn, %{"id" => id, "minute_bar" => minute_bar_params}) do
    minute_bar = Repo.get!(MinuteBar, id)
    changeset = MinuteBar.changeset(minute_bar, minute_bar_params)

    case Repo.update(changeset) do
      {:ok, minute_bar} ->
        render(conn, "show.json", data: minute_bar)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    minute_bar = Repo.get!(MinuteBar, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(minute_bar)

    send_resp(conn, :no_content, "")
  end
end
