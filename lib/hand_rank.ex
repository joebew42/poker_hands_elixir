defmodule HandRank do
  defstruct [:rank, :cards]

  def of(%Hand{cards: cards}) do
    highest_card = highest_card_from(cards)

    %__MODULE__{
      rank: :high_card,
      cards: [highest_card]
    }
  end

  defp highest_card_from(cards) do
    Enum.reduce(cards, &highest_card_between/2)
  end

  defp highest_card_between(card, other_card) do
    case Card.greater_than?(card, other_card) do
      true -> card
      false -> other_card
    end
  end
end
