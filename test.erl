-module(test).
-export([fac/1,double/1,exp/2]).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

double(0) -> 0;
double(N) -> N * 2.

exp(0,P) -> 0;
exp(X,0) -> 1;
exp(X,1) -> X;
exp(X,P) -> X * exp(X,P-1).
