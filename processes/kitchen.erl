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

fridge2(FoodsList) ->
  receive
    {From, {store, Food}} ->
      From ! {self(), {Food,ok}},
      fridge2([Food | FoodsList]);
    {From, {take, Food}} ->
      case lists:member(Food, FoodsList) of
        true ->
          From ! {self(), {Food,ok}},
          fridge2(lists:delete(Food, FoodsList));
        false->
          From ! {self(), {Food,not_found}}
      end;
    terminate -> 
      ok
  end.

start(FoodList) ->
  spawn(?MODULE, fridge2, [FoodList]).

store(Pid,Food) ->
  Pid ! {self(), {store,Food}},
  receive
    {Pid, Msg} -> Msg
  end.

store2(Pid,Food) ->
  Pid ! {self(),{store,Food}},
  receive
    {Pid, Msg} -> Msg
  after 3000 ->
    timeout
  end.

take(Pid, Food) ->
  Pid ! {self(), {take,Food}}, 
  receive
    {Pid, Msg} -> Msg
  end.

take2(Pid, Food) ->
  Pid ! {self(),{take,Food}},
  receive
    {Pid, Msg} -> Msg
  after 3000 ->
    timeout
  end.
