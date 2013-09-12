-module(first).
-export([start/0, say_something/2]).

say_something(What, 0) -> done;
say_something(What, Times) ->
  io:format("~p~n", [What]),
  say_something(What, Times -1).

start() ->
  spawn(first, say_something, [heya,4]),
  spawn(first, say_something, [bye,4]).
