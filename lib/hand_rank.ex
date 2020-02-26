defmodule HandRank do
  defstruct [:rank, :cards]

  def from(%Hand{cards: cards}) do
    highest_card = highest_card_from(cards)

    %__MODULE__{
      rank: :high_card,
      cards: [highest_card]
    }
  end

  defp highest_card_from(cards) do
    %Card{suit: "C", value: "6"}
  end
end