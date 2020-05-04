defmodule HandRank do
  @type name :: :high_card | :one_pair | :two_pair
  @type point :: list(Card.t())
  @type t :: %__MODULE__{name: name(), point: point()}

  defstruct [:name, :point]

  @spec of(Hand.t()) :: t()
  def of(%Hand{cards: cards}) do
    break_condition = fn hand_rank -> hand_rank.point != [] end
    rules = [
      &straight_from/1,
      &three_of_kind_from/1,
      &two_pair_from/1,
      &one_pair_from/1,
      &highest_card_from/1
    ]

    match_first(cards, rules, break_condition)
  end

  defp straight_from(cards) do
    cards
    |> sort_by_card_rank()
    |> with_five_cards_in_a_sequence()
    |> to_hand_rank(:straight)
  end

  defp three_of_kind_from(cards) do
    cards
    |> group_cards_by_same_rank()
    |> with_three_cards_each()
    |> to_hand_rank(:three_of_kind)
  end

  defp two_pair_from(cards) do
    cards
    |> group_cards_by_same_rank()
    |> with_two_cards_each()
    |> with_total_number_of_cards(4)
    |> to_hand_rank(:two_pair)
  end

  defp one_pair_from(cards) do
    cards
    |> group_cards_by_same_rank()
    |> with_two_cards_each()
    |> to_hand_rank(:one_pair)
  end

  defp highest_card_from(cards) do
    high_card = Enum.reduce(cards, &highest_card_between/2)

    to_hand_rank([high_card], :high_card)
  end

  defp to_hand_rank(point, name) do
    %__MODULE__{name: name, point: point}
  end

  defp with_three_cards_each(cards_grouped_by_rank) do
    cards_grouped_by_rank
    |> Enum.filter(fn cards -> length(cards) == 3 end)
    |> Enum.concat()
  end

  defp with_two_cards_each(cards_grouped_by_rank) do
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

  defp highest_card_between(card, other_card) do
    case Card.greater_than?(card, other_card) do
      true -> card
      false -> other_card
    end
  end

  defp sort_by_card_rank(cards) do
    cards
    |> Enum.sort(&Card.greater_than?/2)
    |> Enum.reverse()
  end

  defp with_five_cards_in_a_sequence(cards, result \\ [])
  defp with_five_cards_in_a_sequence([card], result) do
    Enum.reverse([card|result])
  end
  defp with_five_cards_in_a_sequence([card | other], result) do
    [next_card|_] = other

    case Card.consecutive?(card, next_card) do
      true ->
        with_five_cards_in_a_sequence(other, [card|result])
      false ->
        []
    end
  end

  defp match_first(_element, [], _break_condition) do
    nil # or default
  end
  defp match_first(element, [rule | remaining_rules], break_condition) do
    result = rule.(element)
    case break_condition.(result) do
      true ->
        result
      _ ->
        match_first(element, remaining_rules, break_condition)
    end
  end
end
