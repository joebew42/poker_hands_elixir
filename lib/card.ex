defmodule Card do
  @type suit :: :clubs | :diamonds | :hearts | :spades
  @type rank :: :ace | :king | :queen | :jack | 2..10
  @type t :: %__MODULE__{suit: suit(), rank: rank()}

  defstruct [:suit, :rank]

  @spec clubs_of(rank()) :: t()
  def clubs_of(rank), do: of(:clubs, rank)

  @spec diamonds_of(rank()) :: t()
  def diamonds_of(rank), do: of(:diamonds, rank)

  @spec hearts_of(rank()) :: t()
  def hearts_of(rank), do: of(:hearts, rank)

  @spec of(suit(), rank()) :: t()
  def of(suit, rank) do
    %__MODULE__{suit: suit, rank: rank}
  end

  @spec greater_than?(t(), t()) :: boolean()
  def greater_than?(%__MODULE__{rank: rank}, %__MODULE__{rank: other_rank}) do
    to_integer(rank) > to_integer(other_rank)
  end

  defp to_integer(rank) when is_integer(rank), do: rank
  defp to_integer(:jack), do: 11
  defp to_integer(:queen), do: 12
  defp to_integer(:king), do: 13
  defp to_integer(:ace), do: 14
end
