defmodule Hand do
  defstruct [:cards]

  def with(cards) do
    %__MODULE__{cards: cards}
  end
end
