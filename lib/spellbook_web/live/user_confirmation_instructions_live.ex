defmodule SpellbookWeb.UserConfirmationInstructionsLive do
  use SpellbookWeb, :live_view

  alias Spellbook.Accounts

  def render(assigns) do
    ~H"""
    <div class="sp-gradient flex items-center justify-center flex-col">
      <div class="mx-auto max-w-sm">
        <h1 class="font-brand font-bold text-3xl text-white">
          No confirmation instructions received?
          <h2 class="text-white">We'll send a new confirmation link to your inbox</h2>
        </h1>
      </div>
    </div>

    <div class="w-1/2 mx-auto -mt-[48px]">
    <.simple_form for={@form} id="resend_confirmation_form" phx-submit="send_instructions">
      <.input field={@form[:email]} type="email" placeholder="Email" required />
      <:actions>
        <.button phx-disable-with="Sending..." class="w-full">
          Resend confirmation instructions
        </.button>
      </:actions>
    </.simple_form>

      <p class="text-center mt-4">
        <.link href={~p"/users/register"}>Register</.link>
        | <.link href={~p"/users/log_in"}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_instructions", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_confirmation_instructions(
        user,
        &url(~p"/users/confirm/#{&1}")
      )
    end

    info =
      "If your email is in our system and it has not been confirmed yet, you will receive an email with instructions shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
