-module(linkmon).
-compile(export_all).

myproc() ->
  timer:sleep(5000),
  exit(something).

chain(0) ->
  receive
    _ -> ok
  after 2000 ->
    exit("death of chain starts here")
  end;
chain(N) ->
  Pid = spawn(fun() -> chain(N-1) end),
  link(Pid),
  receive
    _ -> ok
  end.

start_critic() ->
  spawn(?MODULE, critic, []).

judge(Pid, Band, Album) ->
  Pid ! {self(), {Band, Album}},
  receive
    {Pid, Criticism} -> Criticism
  after 2000 ->
    timeout
  end.

critic() ->
  receive
    {From, {"Rage against the machine","Battle of Los Angeles"}} -> From ! {self(), "awesome!!"};
    {From, {"Johnny Cash", "Folsom Prison Blues"}} -> From ! {self(), "Beautiful"};
    {From, {Band, Album}} -> From ! {self(), "Garbage!"}
  end,
  critic().
