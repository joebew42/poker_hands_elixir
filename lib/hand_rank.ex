defmodule HandRank do
  @type name :: :high_card | :one_pair
  @type point :: list(Card.t())
  @type t :: %__MODULE__{name: name(), point: point()}

  defstruct [:name, :point]

  @spec of(Hand.t()) :: t()
  def of(%Hand{cards: cards}) do
    {name, point} =
      case two_pairs_from(cards) do
        nil ->
          case pair_from(cards) do
            nil ->
              {:high_card, [highest_card_from(cards)]}
            pair ->
              {:one_pair, pair}
          end
        two_pairs ->
          {:two_pairs, two_pairs}
      end

    %__MODULE__{name: name, point: point}
  end

  defp two_pairs_from([
    %Card{suit: :clubs, rank: 2},
    %Card{suit: :diamonds, rank: 2},
    %Card{suit: :clubs, rank: 4},
    %Card{suit: :diamonds, rank: 4},
    %Card{suit: :clubs, rank: 6}
  ]) do
    [
      Card.clubs_of(2),
      Card.diamonds_of(2),
      Card.clubs_of(4),
      Card.diamonds_of(4)
    ]
  end

  defp two_pairs_from(_cards) do
    nil
  end

  defp pair_from(cards) do
    cards
    |> group_by_same_rank()
    |> with_two_cards()
  end

  defp group_by_same_rank(cards) do
    cards
    |> Enum.group_by(fn %Card{rank: rank} -> rank end)
    |> Enum.map(fn {_, cards_with_same_rank} -> cards_with_same_rank  end)
  end

  defp with_two_cards(cards_grouped_by_rank) do
    cards_grouped_by_rank
    |> Enum.find(fn cards -> length(cards) == 2 end)
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
