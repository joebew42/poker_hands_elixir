defmodule HandRank do
  @type name :: :high_card | :one_pair | :two_pair
  @type point :: list(Card.t())
  @type t :: %__MODULE__{name: name(), point: point()}

  defstruct [:name, :point]

  @spec of(Hand.t()) :: t()
  def of(%Hand{cards: cards}) do
    {name, point} =
      case two_pair_from(cards) do
        [] ->
          case one_pair_from(cards) do
            [] ->
              {:high_card, [highest_card_from(cards)]}
            pair ->
              {:one_pair, pair}
          end
        two_pair ->
          {:two_pair, two_pair}
      end

    %__MODULE__{name: name, point: point}
  end

  defp one_pair_from(cards) do
    cards
    |> group_cards_by_same_rank()
    |> that_has_two_cards_each()
    |> with_total_number_of_cards(2)
  end

  defp two_pair_from(cards) do
    cards
    |> group_cards_by_same_rank()
    |> that_has_two_cards_each()
    |> with_total_number_of_cards(4)
  end

  defp that_has_two_cards_each(cards_grouped_by_rank) do
    cards_grouped_by_rank
    |> Enum.filter(fn cards -> length(cards) == 2 end)
    |> Enum.concat()
  end

  defp with_total_number_of_cards(cards, number_of_cards) do
    case length(cards) do
      ^number_of_cards ->
        cards
      _ ->
        []
    end
  end

  defp group_cards_by_same_rank(cards) do
    cards
    |> Enum.group_by(fn %Card{rank: rank} -> rank end)
    |> Enum.map(fn {_, cards_with_same_rank} -> cards_with_same_rank  end)
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
