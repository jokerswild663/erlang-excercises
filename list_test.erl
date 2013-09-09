-module(list_test).
-export([list_length/1,max_list/1,min_list/1,reverse_list/1]).

list_length([]) -> 0;
list_length([First | Rest]) -> 1 + list_length(Rest).

%*****************************Max list************************

max_list([Head | Rest]) -> max_list(Rest,Head).

max_list([], Result_so_far) -> Result_so_far;
max_list([Head | Remaining], Result_so_far) when Head > Result_so_far -> max_list(Remaining, Head);
max_list([Head | Remaining], Result_so_far) -> max_list(Remaining, Result_so_far).

%*************************************************************

%*****************************Min list************************

min_list([Head | Rest]) -> min_list(Rest,Head).

min_list([], Result_so_far) -> Result_so_far;
min_list([Head | Remnant], Result_so_far) when Head < Result_so_far -> min_list(Remnant, Head);
min_list([Head | Remnant], Result_so_far) -> min_list(Remnant, Result_so_far).

%*************************************************************

%*************************Reverse list************************

reverse_list(Original_list) -> reverse_list(Original_list, []).

reverse_list([Head | First_List], New_List) -> reverse_list(First_List, [Head | New_List]);
reverse_list([], New_List) -> New_List.

%*************************************************************
