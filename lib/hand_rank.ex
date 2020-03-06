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
    cards
    |> Enum.reduce(fn card, current_highest_card ->
      case Card.greater_than?(card, current_highest_card) do
        true -> card
        false -> current_highest_card
      end
    end)
  end
end
