defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has a flush" do
    test "returns the five cards with the same suit" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.clubs_of(3),
          Card.clubs_of(4),
          Card.clubs_of(5),
          Card.clubs_of(8)
        ])

      assert flush?(hand,
               with: [
                 Card.clubs_of(2),
                 Card.clubs_of(3),
                 Card.clubs_of(4),
                 Card.clubs_of(5),
                 Card.clubs_of(8)
               ]
             )
    end
  end

  describe "when a hand has a straight" do
    test "returns the five cards in a sequence" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.diamonds_of(4),
          Card.hearts_of(3),
          Card.diamonds_of(6),
          Card.clubs_of(5)
        ])

      assert straight?(hand,
               with: [
                 Card.clubs_of(2),
                 Card.hearts_of(3),
                 Card.diamonds_of(4),
                 Card.clubs_of(5),
                 Card.diamonds_of(6)
               ]
             )
    end
  end

  describe "when a hand has a three of kind" do
    test "returns the three cards with the same rank" do
      hand =
        Hand.with([
          Card.clubs_of(2),
          Card.diamonds_of(2),
          Card.hearts_of(2),
          Card.diamonds_of(4),
          Card.clubs_of(6)
        ])

      assert three_of_kind?(hand,
               with: [
                 Card.clubs_of(2),
                 Card.diamonds_of(2),
                 Card.hearts_of(2)
               ]
             )
    end
  end

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

      assert two_pair?(hand,
               with: [
                 Card.clubs_of(2),
                 Card.diamonds_of(2),
                 Card.clubs_of(4),
                 Card.diamonds_of(4)
               ]
             )
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
          Card.diamonds_of(7)
        ])

      assert high_card?(hand, with: Card.diamonds_of(7))
    end
  end

  defp high_card?(hand, with: card) do
    assert HandRank.of(hand) == %HandRank{name: :high_card, point: [card]}
  end

  defp one_pair?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :one_pair, point: cards}
  end

  defp two_pair?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :two_pair, point: cards}
  end

  defp three_of_kind?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :three_of_kind, point: cards}
  end

  defp straight?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :straight, point: cards}
  end

  defp flush?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :flush, point: cards}
  end
end
