defmodule ResultPrinter do
  @spec print(Result.t()) :: String.t()

  def print(:tie) do
    "tie"
  end

  def print(%Player{name: name, hand: hand}) do
    "#{name} wins. - with #{print_hand_rank(HandRank.of(hand))}"
  end

  @spec print_hand_rank(HandRank.t()) :: String.t()
  defp print_hand_rank(%HandRank{name: name}) do
    name
    |> Atom.to_string()
    |> String.replace("_", " ")
  end
end
