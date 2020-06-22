defmodule Player do
  @type name :: String.t()
  @type t :: %__MODULE__{name: name(), hand: Hand.t()}

  defstruct [:name, :hand]

  @spec play_against(t(), t()) :: t()
  def play_against(player, other_player) do
    player_hand_rank = HandRank.of(player.hand)
    other_player_hand_rank = HandRank.of(other_player.hand)

    case HandRank.compare(player_hand_rank, other_player_hand_rank) do
      {:first, _} -> player
      {:second, _} -> other_player
      other -> raise "NOT YET IMPLEMENTED #{inspect(other)}"
    end
  end
end
