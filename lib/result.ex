defmodule Result do
  @type winner :: Player.t()
  @type tie :: :tie

  @type t :: winner() | tie()

  @spec tie() :: tie()
  def tie(), do: :tie
end
