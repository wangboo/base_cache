defmodule BaseCacheTest do
  use ExUnit.Case
  import BaseCache
  doctest BaseCache

  test "the truth" do
  	new_cache("item")
    assert 1 + 1 == 2
  end
end
