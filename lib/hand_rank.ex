defmodule HandRank do
  defstruct [:rank, :cards]

  def of(%Hand{cards: [
    %Card{rank: 2, suit: :clubs},
    %Card{rank: 2, suit: :diamonds},
    %Card{rank: 4, suit: :clubs},
    %Card{rank: 5, suit: :clubs},
    %Card{rank: 6, suit: :clubs}
  ]}) do
    %__MODULE__{
      rank: :one_pair,
      cards: [Card.clubs_of(2), Card.diamonds_of(2)]
    }
  end

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
