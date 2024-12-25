defmodule TrarecordWeb.UserLoginLive do
  use TrarecordWeb, :live_view

  def render(assigns) do
    ~H"""
    <div id="login" class="m-auto pt-12 h-screen w-[80vw]">
      <.header class="text-center">
        <%= gettext("Sign In") %>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <ul>
            <li class="mb-2">
              <.link
                id="forgort-password"
                href={~p"/users/reset_password"}
                class="text-sm font-semibold underline"
              >
                <%= gettext("Forgot your password?") %>
              </.link>
            </li>
            <li>
              <.link
                id="signup"
                navigate={~p"/users/register"}
                class="font-semibold text-sm underline"
              >
                <%= gettext("Sign up here") %>
              </.link>
            </li>
          </ul>
        </:actions>
        <:actions>
          <.button phx-disable-with={gettext("Signing in...")} class="w-full">
            <%= gettext("Sign In") %>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
