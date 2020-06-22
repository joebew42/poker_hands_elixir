defmodule Player do
  @type name :: String.t()
  @type t :: %__MODULE__{name: name(), hand: Hand.t()}

  defstruct [:name, :hand]

  @spec play_against(t(), t()) :: t()
  def play_against(player, other_player) do
    player
  end
end
