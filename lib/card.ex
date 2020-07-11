defmodule Card do
  @type suit :: :clubs | :diamonds | :hearts | :spades
  @type rank :: :ace | :king | :queen | :jack | 2..10
  @type t :: %__MODULE__{suit: suit(), rank: rank()}

  defstruct [:suit, :rank]

  @spec clubs() :: suit()
  def clubs(), do: :clubs

  @spec diamonds() :: suit()
  def diamonds(), do: :diamonds

  @spec hearts() :: suit()
  def hearts(), do: :hearts

  @spec spades() :: suit()
  def spades(), do: :spades

  @spec ace :: rank()
  def ace(), do: :ace

  @spec king :: rank()
  def king(), do: :king

  @spec queen :: rank()
  def queen(), do: :queen

  @spec jack :: rank()
  def jack(), do: :jack

  @spec clubs_of(rank()) :: t()
  def clubs_of(rank), do: of(:clubs, rank)

  @spec diamonds_of(rank()) :: t()
  def diamonds_of(rank), do: of(:diamonds, rank)

  @spec hearts_of(rank()) :: t()
  def hearts_of(rank), do: of(:hearts, rank)

  @spec spades_of(rank()) :: t()
  def spades_of(rank), do: of(:spades, rank)

  @spec of(suit(), rank()) :: t()
  def of(suit, rank) do
    %__MODULE__{suit: suit, rank: rank}
  end

  @spec highest_between(t(), t()) :: t()
  def highest_between(card, other_card) do
    case greater_than?(card, other_card) do
      true -> card
      false -> other_card
    end
  end

  @spec greater_than?(t(), t()) :: boolean()
  def greater_than?(%__MODULE__{rank: rank}, %__MODULE__{rank: other_rank}) do
    to_integer(rank) > to_integer(other_rank)
  end

  @spec consecutive_rank?(t(), t()) :: boolean()
  def consecutive_rank?(%__MODULE__{rank: rank}, %__MODULE__{rank: other_rank}) do
    to_integer(rank) + 1 == to_integer(other_rank)
  end

  @spec same_suit?(t(), t()) :: boolean()
  def same_suit?(%__MODULE__{suit: suit}, %__MODULE__{suit: other_suit}) do
    suit == other_suit
  end

  defp to_integer(rank) when is_integer(rank), do: rank
  defp to_integer(:jack), do: 11
  defp to_integer(:queen), do: 12
  defp to_integer(:king), do: 13
  defp to_integer(:ace), do: 14
end
