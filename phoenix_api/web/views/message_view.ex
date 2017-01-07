defmodule PhoenixApi.MessageView do
  use PhoenixApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:content]
end
