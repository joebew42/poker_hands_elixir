defmodule CardTest do
  use ExUnit.Case, async: true

  @pairs_of_rank_with_its_subsequent_higher_rank [
    {2, 3},
    {3, 4},
    {4, 5},
    {5, 6},
    {6, 7},
    {7, 8},
    {9, 10},
    {10, :jack},
    {:jack, :queen},
    {:queen, :king},
    {:king, :ace},
  ]

  describe "greater_than?/2" do
    test "true when the card is greater than the other" do
      @pairs_of_rank_with_its_subsequent_higher_rank
      |> Enum.each(fn {rank, subsequent_higher_rank} ->
        assert Card.greater_than?(Card.clubs_of(subsequent_higher_rank), Card.clubs_of(rank))
      end)
    end

    test "false when the card is not greater than the other" do
      @pairs_of_rank_with_its_subsequent_higher_rank
      |> Enum.each(fn {rank, subsequent_higher_rank} ->
        refute Card.greater_than?(Card.clubs_of(rank), Card.clubs_of(subsequent_higher_rank))
      end)
    end
  end
end