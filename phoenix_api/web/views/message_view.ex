defmodule PhoenixApi.MessageView do
  use PhoenixApi.Web, :view

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, PhoenixApi.MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, PhoenixApi.MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      content: message.content,
      portfolio_id: message.portfolio_id}
  end
end
