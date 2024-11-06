defmodule SpellbookWeb.SpellFormComponent do
  use SpellbookWeb, :live_component
  alias Spellbook.{Spells, Spells.Spell}

  def mount(socket) do
    empty_spell = Spells.change_spell(%Spell{})
    new_socket = assign(socket, form: to_form(empty_spell))

    {:ok, new_socket}
  end
  
  def handle_event("validate", %{"spell" => params}, socket) do
    changeset = %Spell{}
      |> Spells.change_spell(params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("create", %{"spell" => params}, socket) do
    if is_nil(params["id"]) do
      create_spell(params, socket)
    else
      update_spell(params, socket)
    end
  end

  defp create_spell(params, socket) do
    case Spells.create_spell(socket.assigns.current_user, params) do
      {:ok, spell} ->
        socket = push_event(socket, "spell-created", %{})
        changeset = Spells.change_spell(%Spell{})
        socket = assign(socket, :form, to_form(changeset))
        {:noreply, push_navigate(socket, to: ~p"/spell?#{[id: spell]}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp update_spell(params, socket) do
    case Spells.update_spell(socket.assigns.current_user, params) do
      {:ok, spell} ->
        {:noreply, push_patch(socket, to: ~p"/spell?#{[id: spell]}")}

      {:error, message} ->
        socket = put_flash(socket, :error, message)
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="create" phx-change="validate" phx-target={@myself}>
        <div class="justify center px-28 w-full space-y-4 mb-10">
          <.input
            field={@form[:description]}
            placeholder="Spell description..."
            autocomplete="off"
            phx-debounce="blur"
          />
          <div>
            <div class="flex p-2 items-center bg-spDark rounded-t-md border border-b-0">
              <div class="w-[300px] mb-2">
                <.input
                  field={@form[:name]}
                  placeholder="Filename including extension..."
                  autocomplete="off"
                  phx-debounce="blur"
                />
              </div> 
             </div>
             <div id="create-spell-wrapper" class="flex w-full" phx-update="ignore">
               <textarea
                 id="create-line-numbers"
                 class="line-numbers"
                 readonly
               ><%= "1\n" %></textarea>
               <div class="w-full">
                 <.input
                   id="spell-textarea"
                   phx-hook="UpdateLineNumber"
                   field={@form[:markup_text]}
                   type="textarea"
                   placeholder="Write your spell"
                   spellcheck="false"
                   autocomplete="off"
                   phx-debounce="blur"
                 />
               </div>
            </div>
          </div>
          <div class="flex justify-end">
            <%= if @id == :new do %>
              <.button class="create_button" phx-disable-with="Creating...">Create Spell</.button>
            <% else %>
              <.button class="create_button" phx-disable-with="Editing...">Edit Spell</.button>
            <% end %>
          </div>
        </div>
      </.form>
    </div>
    """
  end
end
