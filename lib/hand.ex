defmodule Hand do
  @type cards :: list(Card.t())
  @type t :: %__MODULE__{cards: cards()}

  defstruct [:cards]

  @spec with(cards()) :: t()
  def with(cards) do
    %__MODULE__{cards: cards}
  end
end
