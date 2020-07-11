defmodule GameParser do
  @players_separator "  "
  @player_hand_separator ": "
  @card_separator " "

  @spec parse(String.t()) :: list(Player.t())
  def parse(game_as_string) do
    game_as_string
    |> String.split(@players_separator)
    |> Enum.map(&GameParser.parse_player/1)
  end

  @spec parse_player(String.t()) :: Player.t()
  def parse_player(player_as_string) do
    [player_name, hand_as_string] = String.split(player_as_string, @player_hand_separator)

    hand = parse_hand(hand_as_string)

    %Player{name: player_name, hand: hand}
  end

  @spec parse_hand(String.t()) :: Hand.t()
  defp parse_hand(hand_as_string) do
    cards =
      hand_as_string
      |> String.split(@card_separator)
      |> Enum.map(&parse_card/1)

    %Hand{cards: cards}
  end

  @spec parse_card(String.t()) :: Card.t()
  defp parse_card(card_as_string) do
    rank_as_string = String.at(card_as_string, 0)
    suit_as_string = String.at(card_as_string, 1)

    Card.of(
      parse_suit(suit_as_string),
      parse_rank(rank_as_string)
    )
  end

  @spec parse_suit(String.t()) :: Card.suit()
  defp parse_suit("C"), do: Card.clubs()
  defp parse_suit("D"), do: Card.diamonds()
  defp parse_suit("H"), do: Card.hearts()
  defp parse_suit("S"), do: Card.spades()

  @spec parse_rank(String.t()) :: Card.rank()
  defp parse_rank("A"), do: Card.ace()
  defp parse_rank("K"), do: Card.king()
  defp parse_rank("Q"), do: Card.queen()
  defp parse_rank("J"), do: Card.jack()
  defp parse_rank(rank_as_string), do: String.to_integer(rank_as_string)
end
