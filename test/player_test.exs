defmodule PlayerTest do
  use ExUnit.Case, async: true

  describe "play_against/2" do
    test "returns the player that has the winning poker hand" do
      winner_player = %Player{name: "WinnerPlayerName", hand: royal_flush()}
      loser_player = %Player{name: "LoserPlayerName", hand: high_card()}

      assert Player.play_against(winner_player, loser_player) == winner_player
      assert Player.play_against(loser_player, winner_player) == winner_player
    end
  end

  defp royal_flush() do
    Hand.with([
      Card.hearts_of(10),
      Card.hearts_of(:jack),
      Card.hearts_of(:queen),
      Card.hearts_of(:king),
      Card.hearts_of(:ace)
    ])
  end

  defp high_card() do
    Hand.with([
      Card.clubs_of(5),
      Card.hearts_of(:jack),
      Card.hearts_of(:queen),
      Card.diamonds_of(:king),
      Card.hearts_of(:ace)
    ])
  end
end
