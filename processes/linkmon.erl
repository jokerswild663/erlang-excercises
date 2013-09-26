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
