-module('conditionals').
-export([chosen/1]).

chosen([]) -> something;
chosen(N) -> 
  case N of
    {cent, Change} when Change < 3 -> 'small';
    {cent, Change} when Change > 3  -> 'large'
  end.
