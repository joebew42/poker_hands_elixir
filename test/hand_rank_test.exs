defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has a no pair" do
    test "it returns the high card" do
      hand =
        Hand.with([
          Card.club_of("2"),
          Card.club_of("3"),
          Card.club_of("4"),
          Card.club_of("5"),
          Card.club_of("6")
        ])

      assert a_high_card_rank?(HandRank.of(hand), with: Card.club_of("6"))
    end
  end

  defp a_high_card_rank?(hand_rank, with: card) do
    hand_rank == %HandRank{rank: :high_card, cards: [card]}
  end
end
