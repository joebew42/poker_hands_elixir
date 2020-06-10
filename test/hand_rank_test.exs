defmodule HandRankTest do
  use ExUnit.Case, async: true

  @lower_point [
    %Card{suit: :clubs, rank: 2}
  ]

  @any_point [
    %Card{suit: :clubs, rank: :ace}
  ]

  describe "compare/2" do
    test "when both are tie returns the highest rank comparing by highest card" do
      rank_with_lower_point = %HandRank{name: :high_card, point: @lower_point}
      rank_with_higher_point = %HandRank{name: :high_card, point: @any_point}

      assert {:first, rank_with_higher_point} == HandRank.compare(rank_with_higher_point, rank_with_lower_point)
      assert {:second, rank_with_higher_point} == HandRank.compare(rank_with_lower_point, rank_with_higher_point)
    end

    test "returns tie when there is no high rank between two" do
      high_card = %HandRank{name: :high_card, point: @any_point}

      assert :tie == HandRank.compare(high_card, high_card)
    end

    test "returns the highest rank between two" do
      one_pair = %HandRank{name: :one_pair, point: @any_point}
      high_card = %HandRank{name: :high_card, point: @any_point}

      assert {:first, one_pair} == HandRank.compare(one_pair, high_card)
      assert {:second, one_pair} == HandRank.compare(high_card, one_pair)
    end
  end

  describe "when a hand has a royal flush" do
    test "returns all cards of the same suit in sequence where the ace is the highest card" do
      hand =
        Hand.with([
          Card.hearts_of(10),
          Card.hearts_of(:jack),
          Card.hearts_of(:queen),
          Card.hearts_of(:king),
          Card.hearts_of(:ace)
        ])

      assert royal_flush?(hand,
               with: [
                 Card.hearts_of(10),
                 Card.hearts_of(:jack),
                 Card.hearts_of(:queen),
                 Card.hearts_of(:king),
                 Card.hearts_of(:ace)
               ]
             )
    end
  end

  describe "when a hand has a straight flush" do
    test "returns the five cards in a sequence with the same suit" do
      hand =
        Hand.with([
          Card.clubs_of(4),
          Card.clubs_of(6),
          Card.clubs_of(2),
          Card.clubs_of(5),
          Card.clubs_of(3)
        ])

      assert straight_flush?(hand,
               with: [
                 Card.clubs_of(2),
                 Card.clubs_of(3),
                 Card.clubs_of(4),
                 Card.clubs_of(5),
                 Card.clubs_of(6)
               ]
             )
    end
  end

  describe "when a hand has a four of a kind" do
    test "returns the four cards the same rank" do
      hand =
        Hand.with([
          Card.spades_of(3),
          Card.clubs_of(3),
          Card.spades_of(2),
          Card.hearts_of(3),
          Card.diamonds_of(3)
        ])

      assert four_of_kind?(hand,
               with: [
                 Card.spades_of(3),
                 Card.clubs_of(3),
                 Card.hearts_of(3),
                 Card.diamonds_of(3)
               ]
             )
    end
  end

  describe "when a hand has a full house" do
    test "returns the three cards and the two cards with the same rank" do
      hand =
        Hand.with([
          Card.diamonds_of(2),
          Card.clubs_of(3),
          Card.spades_of(2),
          Card.hearts_of(3),
          Card.diamonds_of(3)
        ])

      assert fullhouse?(hand,
               with: [
                 Card.clubs_of(3),
                 Card.hearts_of(3),
                 Card.diamonds_of(3),
                 Card.diamonds_of(2),
                 Card.spades_of(2)
               ]
             )
    end
  end

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

  defp fullhouse?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :fullhouse, point: cards}
  end

  defp four_of_kind?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :four_of_kind, point: cards}
  end

  defp straight_flush?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :straight_flush, point: cards}
  end

  defp royal_flush?(hand, with: cards) do
    assert HandRank.of(hand) == %HandRank{name: :royal_flush, point: cards}
  end
end
