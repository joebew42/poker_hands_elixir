defmodule Cards do
  @spec highest_card_from(list(Card.t())) :: Card.t()
  def highest_card_from(cards) do
    Enum.reduce(cards, &Card.highest_between/2)
  end

  @spec any?(list(Card.t()), Card.rank()) :: boolean()
  def any?(cards, rank) do
    Enum.any?(cards, fn card -> card.rank == rank end)
  end

  @spec sort_by_rank(list(Card.t())) :: list(Card.t())
  def sort_by_rank(cards) do
    cards
    |> Enum.sort(&Card.greater_than?/2)
    |> Enum.reverse()
  end
end
