-module(dolphins).
-compile(export_all).

dolphin1() -> 
  receive
    flip -> 
      io:format("Never! ~n");  
    fish ->
      io:format("Sweet! Thank you and goodbye ~n");
    _    ->
      io:format("Don't push me. ~n")
  end.

dolphin2() ->
  receive
    {From,flip} -> 
      io:format("Never! ~n"),
      dolphin2();
    {From,fish} ->
      io:format("Sweet! Thank you and goodbye");
    _ ->
      io:format("Haha. ~n"),
      dolphin2()
  end.

dolphin3() ->
  receive
    {From, flip} ->
      From ! "flip",
      dolphin3();
    {From, fish} ->
      From ! "thanks!";
    {From, argg } ->
      From ! "don't make me destroy you!",
      dolphin3() 
  end.
