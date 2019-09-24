defmodule FlashtiketWeb.ChangesetView do
  use FlashtiketWeb, :view

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{
      status: "error",
      data: nil,
      errors: translate_errors(changeset)
    }
  end
end
