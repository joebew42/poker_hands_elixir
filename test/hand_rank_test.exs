defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has two pairs" do
    test "returns the four cards of the two pairs" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.diamonds_of(2),
          Card.clubs_of(4),
          Card.diamonds_of(4),
          Card.clubs_of(6)
        ])

      assert two_pair?(hand, with: [
        Card.clubs_of(2),
        Card.diamonds_of(2),
        Card.clubs_of(4),
        Card.diamonds_of(4)
      ])
    end
  end

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
    assert HandRank.of(hand) == %HandRank{name: :high_card, point: [card]}
  end

  defp one_pair?(hand, with: [first_card, second_card]) do
    assert HandRank.of(hand) == %HandRank{name: :one_pair, point: [first_card, second_card]}
  end

  defp two_pair?(hand, with: [first_card, second_card, third_card, fourth_card]) do
    assert HandRank.of(hand) == %HandRank{name: :two_pair, point: [first_card, second_card, third_card, fourth_card]}
  end
end
