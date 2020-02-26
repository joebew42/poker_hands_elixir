defmodule HandRankTest do
  use ExUnit.Case, async: true

  describe "when a hand has nothing" do
    test "it returns the highest card" do
      hand = Hand.with([
        Card.of("C", "2"),
        Card.of("C", "3"),
        Card.of("C", "4"),
        Card.of("C", "5"),
        Card.of("C", "6"),
      ])

      assert HandRank.from(hand) |> is_a_high_card_rank?(with: Card.of("C", "6"))
    end
  end

  defp is_a_high_card_rank?(hand_rank, with: card) do
    assert hand_rank == %HandRank{rank: :high_card, cards: [card]}
  end
end
