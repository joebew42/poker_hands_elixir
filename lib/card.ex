defmodule Card do
  @type suit :: :clubs | :diamonds | :hearts | :spades
  @type rank :: :ace | :king | :queen | :jack | 2..10
  @type t :: %__MODULE__{suit: suit(), rank: rank()}

  defstruct [:suit, :rank]

  @spec clubs_of(rank()) :: t()
  def clubs_of(rank), do: of(:clubs, rank)

  @spec of(suit(), rank()) :: t()
  def of(suit, rank) do
    %__MODULE__{suit: suit, rank: rank}
  end
end
