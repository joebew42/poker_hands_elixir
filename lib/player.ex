defmodule Player do
  @type name :: String.t()
  @type t :: %__MODULE__{name: name(), hand: Hand.t()}

  defstruct [:name, :hand]

  @spec play_against(t(), t()) :: t() | :tie
  def play_against(player, other_player) do
    case Hand.play_against(player.hand, other_player.hand) do
      :first -> player
      :second -> other_player
      :tie -> :tie
    end
  end
end
