-module(list_test).
-export([list_length/1,max_list/1]).

list_length([]) -> 0;
list_length([First | Rest]) -> 1 + list_length(Rest).

%*****************************Max list************************

max_list([Head | Rest]) -> max_list(Rest,Head).

max_list([], Result_so_far) -> Result_so_far;
max_list([Head | Remaining], Result_so_far) when Head > Result_so_far -> max_list(Remaining, Head);
max_list([Head | Remaining], Result_so_far) -> max_list(Remaining, Result_so_far).

%*************************************************************
