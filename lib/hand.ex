defmodule Hand do
  @type cards :: list(Card.t())
  @type t :: %__MODULE__{cards: cards()}

  defstruct [:cards]

  @spec with(cards()) :: t()
  def with(cards) do
    %__MODULE__{cards: cards}
  end

  @spec play_against(t(), t()) :: :first | :second | :tie
  def play_against(hand, other_hand) do
    case HandRank.compare(HandRank.of(hand), HandRank.of(other_hand)) do
      {:first, _} -> :first
      {:second, _} -> :second
      :tie -> :tie
    end
  end
end
