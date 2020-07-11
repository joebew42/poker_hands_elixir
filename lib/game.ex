defmodule Game do
  @spec play(String.t()) :: String.t()
  def play(game_as_string) do
    [first_player, second_player] = GameParser.parse(game_as_string)

    first_player
    |> Player.play_against(second_player)
    |> ResultPrinter.print()
  end
end
