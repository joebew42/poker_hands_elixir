defmodule GameTest do
  use ExUnit.Case, async: true

  describe "when a player wins the game" do
    test "prints its name and rank" do
      output = Game.play("Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH")

      assert output == "White wins. - with high card"
    end
  end

  describe "when a game is tie" do
    test "prints out tie" do
      output = Game.play("Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH")

      assert output == "tie"
    end
  end
end
