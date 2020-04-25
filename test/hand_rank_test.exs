defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has one pair" do
    test "returns the two cards with the same rank" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.diamonds_of(2),
          Card.clubs_of(4),
          Card.clubs_of(5),
          Card.clubs_of(6)
        ])

      assert one_pair?(hand, with: [Card.clubs_of(2), Card.diamonds_of(2)])
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

      assert high_card?(hand, with: Card.clubs_of(6))
    end
  end

  defp high_card?(hand, with: card) do
    HandRank.of(hand) == %HandRank{name: :high_card, point: [card]}
  end

  defp one_pair?(hand, with: [first_card, second_card]) do
    HandRank.of(hand) == %HandRank{name: :one_pair, point: [first_card, second_card]}
  end
end
