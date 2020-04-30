defmodule HandRank do
  @type name :: :high_card | :one_pair | :two_pairs
  @type point :: list(Card.t())
  @type t :: %__MODULE__{name: name(), point: point()}

  defstruct [:name, :point]

  @spec of(Hand.t()) :: t()
  def of(%Hand{cards: cards}) do
    {name, point} =
      case two_pairs_from(cards) do
        [] ->
          case pair_from(cards) do
            [] ->
              {:high_card, [highest_card_from(cards)]}
            pair ->
              {:one_pair, pair}
          end
        two_pairs ->
          {:two_pairs, two_pairs}
      end

    %__MODULE__{name: name, point: point}
  end

  defp two_pairs_from(cards) do
    cards
    |> group_by_same_rank()
    |> with_two_cards_each()
  end

  defp pair_from(cards) do
    cards
    |> group_by_same_rank()
    |> only_first_two_cards()
  end

  defp with_two_cards_each(cards) do
    result =
      cards
      |> Enum.filter(fn cards -> length(cards) == 2 end)
      |> Enum.concat()

    case length(result) do
      4 ->
        result
      _ ->
        []
    end
  end

  defp group_by_same_rank(cards) do
    cards
    |> Enum.group_by(fn %Card{rank: rank} -> rank end)
    |> Enum.map(fn {_, cards_with_same_rank} -> cards_with_same_rank  end)
  end

  defp only_first_two_cards(cards_grouped_by_rank) do
    cards_grouped_by_rank
    |> Enum.find([], fn cards -> length(cards) == 2 end)
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
