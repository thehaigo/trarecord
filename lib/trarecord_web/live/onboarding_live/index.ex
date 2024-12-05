defmodule TrarecordWeb.OnboardingLive.Index do
  use TrarecordWeb, :live_view

  def render(assigns) do
    ~H"""
    <div
      class="flex justify-center w-screen h-screen bg-local bg-contain bg-center bg-no-repeat"
      style={"background-image: url(#{@page_data.image}); background-color: #{@page_data.bg}"}
    >
      <div class="grid grid-rows-6 mt-12 text-center">
        <h1 class="text-2xl"><%= raw(@page_data.title) %></h1>
        <p class="text-base -mt-12 row-span-4"><%= raw(@page_data.text) %></p>
        <%= if @page == 3 do %>
          <p class="text-xl cursor-default" phx-click="finish">finish</p>
        <% else %>
          <p class="text-xl cursor-default" phx-click="next">next</p>
        <% end %>
      </div>
    </div>
    <p id="freepik" class="absolute bottom-2 right-4 text-sm">
      <a href={@page_data.link} class="underline text-blue-600">
        Image by storyset on Freepik
      </a>
    </p>
    """
  end

  def mount(_params, _session, socket) do
    socket
    |> assign(:page, 1)
    |> assign(:page_data, Enum.find(intro(), &(&1.page == 1)))
    |> then(&{:ok, &1})
  end

  def handle_event("next", _params, socket) do
    page = socket.assigns.page + 1

    socket
    |> assign(:page, page)
    |> assign(:page_data, Enum.find(intro(), &(&1.page == page)))
    |> then(&{:noreply, &1})
  end

  def handle_event("finish", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  def intro() do
    [
      %{
        page: 1,
        title: "Let's gather where we want to go.",
        text: "You can register <br />various spots using Google search.",
        link:
          "https://www.freepik.com/free-vector/flying-around-world-with-airplane-concept-illustration_8426450.htm#fromView=author&page=1&position=12&uuid=dbcac267-0605-4076-ae43-111dfb07a118",
        image: "/images/flying-around-world.svg",
        bg: "#59b2ab"
      },
      %{
        page: 2,
        title: "Let's organize them in folders.",
        text: "If you have more spots, divide them into <br />folders for easier management.",
        link:
          "https://www.freepik.com/free-vector/resume-folder-concept-illustration_5358953.htm#fromView=author&page=1&position=6&uuid=31a01ff6-d2cb-4798-bc51-89a0517d7ad9",
        image: "/images/folder.svg",
        bg: "#febe29"
      },
      %{
        page: 3,
        title: "Record your travel.",
        text:
          "You can record your memories of actually visiting the spot<br />with GPS logging and Checkin.",
        link:
          "https://www.freepik.com/free-vector/post-concept-illustration_5928515.htm#fromView=author&page=1&position=2&uuid=1450568b-5aac-4d60-a3ad-bef059625d94",
        image: "/images/post.svg",
        bg: "#22bcb5"
      }
    ]
  end
end
