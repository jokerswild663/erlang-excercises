-module(kitchen).
-compile(export_all).
%demonstrating storing and accessing data in state
%http://learnyousomeerlang.com/more-on-multiprocessing

fridge() ->
  receive
    {From, {store, _Food}} ->
      From ! {self(), ok},
      fridge(); 
    {From, {take, _Food}} ->
      From ! {self(), error},
      fridge();
    terminate ->
      ok
  end.
