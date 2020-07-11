defmodule ResultPrinterTest do
  use ExUnit.Case, async: true

  describe "print/1" do
    test "returns tie when the result is :tie" do
      assert ResultPrinter.print(Result.tie()) == "tie"
    end

    test "returns the name of the winner and its hand rank" do
      winner = %Player{
        name: "A Player",
        hand: %Hand{
          cards: [
            Card.hearts_of(2),
            Card.diamonds_of(3),
            Card.spades_of(5),
            Card.clubs_of(9),
            Card.diamonds_of(:king)
          ]
        }
      }

      assert ResultPrinter.print(winner) == "A Player wins. - with high card"
    end
  end
end
