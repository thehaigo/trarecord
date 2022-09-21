defmodule TrarecordWeb.Components.Navigation do
  use Phoenix.Component

  def header(assigns) do
    ~H"""
    <div class="fixed z-20 navbar bg-primary text-primary-content w-full">
      <div class="navbar-start">
      </div>
      <div class="navbar-center">
        <a class="btn btn-ghost normal-case text-4xl"><%= @title %></a>
      </div>
      <div class="navbar-end">
      </div>
    </div>
    """
  end

  def bottom_tab(assigns) do
    ~H"""
    <div class="btm-nav">
    <button class={if @title == "Home", do: "active", else: ""}>
     <a href="/home">
       <span class="btm-nav-label">Home</span>
     </a>
    </button>
    <button class={if @title == "Routes", do: "active", else: ""}>
     <a href="/home">
       <span class="btm-nav-label">Routes</span>
     </a>
    </button>

    <button class={if @title == "Setting", do: "active", else: ""}>
     <a href="users/settings">
       <span class="btm-nav-label">Setting</span>
     </a>
    </button>
    </div>
    """
  end
end
