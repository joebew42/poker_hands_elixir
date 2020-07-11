defmodule Game do
  @spec play(String.t()) :: String.t()
  def play(game_as_string) do
    [first_player, second_player] =
      game_as_string
      |> String.split("  ")
      |> Enum.map(&GameParser.parse_player/1)

    first_player
    |> Player.play_against(second_player)
    |> ResultPrinter.print()
  end
end
