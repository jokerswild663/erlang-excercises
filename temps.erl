-module(temps).
-export([format_temps/1, find_min/1]).

%*************Temperature conversions*********************************
format_temps([]) -> ok;
format_temps([City | RestCities]) -> print_temp(convert_to_celsius(City)), 
format_temps(RestCities).

convert_to_celsius({Name, {c,Temp}}) -> {Name, {c,Temp}};
convert_to_celsius({Name, {f,Temp}}) -> {Name, {c,(Temp - 32) * 5 / 9}}.

find_min([Head | City_List]) -> find_min(City_List, Head).

find_min([],{Name,{c,Min_temp_so_far}}) -> {Name,{c,Min_temp_so_far}};
find_min([{City_Name, {c, City_temp}} | City_List], {Name, {c, Min_temp_so_far}}) -> 
if 
  Min_temp_so_far < City_temp ->
    find_min(City_List, {Name,{c,Min_temp_so_far}});

  Min_temp_so_far >= City_temp -> 
    find_min(City_List, {City_Name, {c, City_temp}})
end.

print_temp({Name, {C,Temp}}) -> io:format("~-15w ~w c~n", [Name,Temp]).
%***********************************************************************
