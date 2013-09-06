-module(test).
-export([fac/1,double/1]).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

double(0) -> 0;
double(N) -> N * 2.
