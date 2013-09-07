-module(list_test).
-export([list_length/1, format_temps/1]).

list_length([]) -> 0;
list_length([First | Rest]) -> 1 + list_length(Rest).


%*************Temperature conversions*********************************
format_temps([]) -> ok;
format_temps([City | RestCities]) -> print_temp(convert_to_celsius(City)), 
format_temps(RestCities).

convert_to_celsius({Name, {c,Temp}}) -> {Name, {c,Temp}};
convert_to_celsius({Name, {f,Temp}}) -> {Name, {c,(Temp - 32) * 5 / 9}}.

print_temp({Name, {C,Temp}}) -> io:format("~-15w ~w c~n", [Name,Temp]).
%***********************************************************************
