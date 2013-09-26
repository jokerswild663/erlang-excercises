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

start_critic2() ->
  spawn(?MODULE, restarter, []).

restarter() ->
  process_flag(trap_exit, true),
  Pid = spawn_link(?MODULE, critic2, []),
  register(critic2, Pid),
  receive
    {"EXIT", normal} -> okay; % normal exiting
    {"EXIT", shutdown} -> okay; % manual shutdown of process.
    {"EXIT", _} -> restarter() % if things go bad.
  end.

judge(Pid, Band, Album) ->
  Pid ! {self(), {Band, Album}},
  receive
    {Pid, Criticism} -> Criticism
  after 2000 ->
    timeout
  end.

judge2(Band, Album) ->
  Ref = make_ref(),
  critic2 ! {self(), Ref,{Band, Album}},
  receive
    {Ref, Criticism} -> Criticism
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

critic2() ->
  receive
    {From, Ref, {"Rage against the machine","Battle of Los Angeles"}} -> From ! {Ref, "awesome!!"};
    {From, Ref, {"Johnny Cash", "Folsom Prison Blues"}} -> From ! {Ref, "Beautiful"};
    {From, Ref, {Band, Album}} -> From ! {Ref, "Garbage!"}
  end,
  critic2().
