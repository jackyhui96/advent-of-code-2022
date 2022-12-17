-module(day05).
-export([p1/0, p2/0]).
% -compile([export_all, {nowarn, export_all}]).

p1() ->
    % String = eg(),
    String = advent:input("d05"),
    ok.

p2() ->
    % String = eg(),
    String = advent:input("d04"),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

eg() -> 
    "    [D]    \n"
    "[N] [C]    \n"
    "[Z] [M] [P]\n"
    " 1   2   3 \n"
    "\n"
    "move 1 from 2 to 1\n"
    "move 3 from 1 to 3\n"
    "move 2 from 2 to 1\n"
    "move 1 from 1 to 2\n".
