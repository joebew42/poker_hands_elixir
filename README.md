# Poker Hands Kata in Elixir

This is an Elixir version for the [Poker Hands Kata](http://codingdojo.org/kata/PokerHands/). There a few points that are still not complete. Feel free to navigate the TODO list below and continue to practice this Kata, or try to start it from the very beginning. Also, try to look at the existing code, is there anything you would like to change or improve?

There is also a [**Java version** of this Code Kata](https://github.com/xpepper/poker-hands-kata). Done in pair programming with [Piero Di Bello](https://twitter.com/pierodibello) and [Matteo Pierro](https://twitter.com/matteo_pierro).

## Let's play

Fetch the dependencies and run all the tests

```
mix deps.get
mix check # to run all the tests
```

Play a game in the console

```
iex -S mix
iex(1)> Game.play("Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S")

"Black wins. - with fullhouse"
```

For other _Suggested Test Cases_ look at the section at the bottom of this README.

## DOING

## TODO

- At the moment the `ResultPrinter` is not able to print the detail of the point, for example with a Full House of 4 4 4 2 2, it should print the point name as `4 over 2`. Look at the _Suggested Test Cases_ section down below.
- The types for the ranks and suits should be moved in their own modules, such as `Rank` and `Suit` (e.g. `Rank.two()`). Now they are in the `Card` module.
- May be better to express the card creation with `Card.three_of(:diamonds)` instead of `Card.diamonds_of(3)`, so to be more aligned with the spoken language of the poker, I say "Three of Hearts", and not "Hearts of Three".
- Does `HandRank.compare` have to return the rank?
- Look at `HandRank`. Some of the functions may be moved to the `Cards` module.
- Try to expose the Game with an HTTP server.

## Nice to Have

- Learning tool: try to integrate [`Credo`](https://github.com/rrrene/credo)
- Write a thread on [Elixir Forum](https://elixirforum.com/) to ask feedback for the `HandRank.match_first` function

## About this Kata

This kata is blatantly stolen from acm.uva.es/p/v103/10315.html It is a subset of KataTexasHoldEm , which is a very large Kata.

## Problem Description

Your job is to compare several pairs of poker hands and to indicate which, if either, has a higher rank.

## Poker rules description

A poker deck contains 52 cards - each card has a suit which is one of clubs, diamonds, hearts, or spades (denoted C, D, H, and S in the input data). Each card also has a value which is one of 2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace (denoted 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A). For scoring purposes, the suits are unordered while the values are ordered as given above, with 2 being the lowest and ace the highest value.

A poker hand consists of 5 cards dealt from the deck. Poker hands are ranked by the following partial order from lowest to highest.

- High Card: Hands which do not fit any higher category are ranked by the value of their highest card. If the highest cards have the same value, the hands are ranked by the next highest, and so on.
- Pair: 2 of the 5 cards in the hand have the same value. Hands which both contain a pair are ranked by the value of the cards forming the pair. If these values are the same, the hands are ranked by the values of the cards not forming the pair, in decreasing order.
- Two Pairs: The hand contains 2 different pairs. Hands which both contain 2 pairs are ranked by the value of their highest pair. Hands with the same highest pair are ranked by the value of their other pair. If these values are the same the hands are ranked by the value of the remaining card.
- Three of a Kind: Three of the cards in the hand have the same value. Hands which both contain three of a kind are ranked by the value of the 3 cards.
- Straight: Hand contains 5 cards with consecutive values. Hands which both contain a straight are ranked by their highest card.
- Flush: Hand contains 5 cards of the same suit. Hands which are both flushes are ranked using the rules for High Card.
- Full House: 3 cards of the same value, with the remaining 2 cards forming a pair. Ranked by the value of the 3 cards.
- Four of a kind: 4 cards with the same value. Ranked by the value of the 4 cards.
- Straight flush: 5 cards of the same suit with consecutive values. Ranked by the highest card in the hand.

## Suggested Test Cases

### Sample input:

```
Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C AH
Black: 2H 4S 4C 2D 4H  White: 2S 8S AS QS 3S
Black: 2H 3D 5S 9C KD  White: 2C 3H 4S 8C KH
Black: 2H 3D 5S 9C KD  White: 2D 3H 5C 9S KH
```

Each row of input is a game with two players. The first five cards belong to the player named "Black" and the second five cards belong to the player named "White".

### Sample output:

```
White wins. - with high card: Ace
Black wins. - with full house: 4 over 2
Black wins. - with high card: 9
Tie.
```
