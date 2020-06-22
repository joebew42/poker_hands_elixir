defmodule Player do
  @type name :: String.t()
  @type t :: %__MODULE__{name: name(), hand: Hand.t()}

  defstruct [:name, :hand]

  @spec play_against(t(), t()) :: t()
  def play_against(player, other_player) do
    case hand_play_against(player.hand, other_player.hand) do
      :first -> player
      :second -> other_player
    end
  end

  # TODO: Move to `Hand`?
  defp hand_play_against(hand, other_hand) do
    case HandRank.compare(HandRank.of(hand), HandRank.of(other_hand)) do
      {:first, _} -> :first
      {:second, _} -> :second
      other -> raise "NOT YET IMPLEMENTED #{inspect(other)}"
    end
  end
end
