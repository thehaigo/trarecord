defmodule TrarecordWeb.Navigation do
  use Phoenix.Component

  import TrarecordWeb.CoreComponents

  attr(:title, :string, default: "")

  slot(:back, doc: "add back navigation within .link component")
  slot(:actions, doc: "add action navigation such as add, edit and etc... within .link component")

  def header_nav(assigns) do
    ~H"""
    <div class="fixed navbar bg-sky-400 text-white w-full z-10 top-0 left-0">
      <div class="navbar-start">
        <span :if={@back != []} class="normal-case text-xl">
          <%= render_slot(@back) %>
        </span>
      </div>
      <div class="navbar-center">
        <span class="normal-case text-4xl">
          <%= @title %>
        </span>
      </div>
      <div class="navbar-end">
        <span :if={@actions != []} class="normal-case text-xl">
          <%= render_slot(@actions) %>
        </span>
      </div>
    </div>
    """
  end

  attr(:current, :string, default: "", doc: "curruent open tab name")

  def bottom_tab(assigns) do
    ~H"""
    <div class="btm-nav">
      <%= for {title, icon ,path} <- links() do %>
        <a href={path} class={if @current == title, do: "active", else: ""}>
          <button>
            <.icon name={icon} class="w-5 h-5" />
            <p class="btm-nav-label"><%= title %></p>
          </button>
        </a>
      <% end %>
    </div>
    """
  end

  defp links() do
    [
      {"Folder", "hero-book-open-solid", "/folders"},
      {"Setting", "hero-cog-6-tooth-solid", "/users/settings"}
    ]
  end
end
