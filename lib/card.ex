defmodule Card do
  @club "C"

  defstruct [:suit, :value]

  def club_of(value), do: of(@club, value)

  def of(suit, value) do
    %__MODULE__{suit: suit, value: value}
  end
end
