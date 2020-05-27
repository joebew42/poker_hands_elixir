defmodule Cards do
  @spec any?(list(Card.t()), Card.rank()) :: boolean()
  def any?(cards, rank) do
    Enum.any?(cards, fn card -> card.rank == rank end)
  end
end