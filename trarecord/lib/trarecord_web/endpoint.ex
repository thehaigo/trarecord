defmodule TrarecordWeb.Endpoint do
  def module() do
    if Mix.target() in [:desktop, :android, :ios] do
      TrarecordWeb.EndpointDesktop
    else
      TrarecordWeb.EndpointWeb
    end
  end
end
