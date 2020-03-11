defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has one pair" do
    test "returns the two cards of one suit" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.diamonds_of(2),
          Card.clubs_of(4),
          Card.clubs_of(5),
          Card.clubs_of(6)
        ])

      assert one_pair_rank?(HandRank.of(hand), with: [
        Card.clubs_of(2), Card.diamonds_of(2)
      ])
    end
  end

  describe "when a hand has a no pair" do
    test "returns the high card" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.clubs_of(3),
          Card.clubs_of(4),
          Card.clubs_of(5),
          Card.clubs_of(6)
        ])

      assert high_card_rank?(HandRank.of(hand), with: Card.clubs_of(6))
    end
  end

  defp high_card_rank?(hand_rank, with: card) do
    hand_rank == %HandRank{rank: :high_card, cards: [card]}
  end

  defp one_pair_rank?(hand_rank, with: [first_card, second_card]) do
    hand_rank == %HandRank{rank: :one_pair, cards: [first_card, second_card]}
  end
end
