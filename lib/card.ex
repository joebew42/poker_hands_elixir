defmodule Card do
  defstruct [:suit, :value]

  def of(suit, value) do
    %__MODULE__{suit: suit, value: value}
  end
end