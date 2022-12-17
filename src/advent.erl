-module(advent).

-export([
    run/1,
    race/1,
    input/1]).

%%%%%%%%%%%
%%% API %%%
%%%%%%%%%%%

%% @doc just run the day
run(N) ->
    Mod = day_to_module(N),
    
{Mod:p1(), Mod:p2()}.

%% @doc just run the day
race(N) ->
    Mod = day_to_module(N),
    T0 = erlang:monotonic_time(millisecond),
    P1 = Mod:p1(),
    T1 = erlang:monotonic_time(millisecond),
    P2 = Mod:p2(),
    T2 = erlang:monotonic_time(millisecond),
    {{T1-T0, P1}, {T2-T1, P2}}.
    

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
day_to_module(N) ->
    list_to_atom("day" ++ io_lib:format("~2..0B", [N])).

input(Day) ->
    Priv = code:priv_dir(advent),
    File = filename:join([Priv, 
        Day]),
    {ok, Bin} = file:read_file(File),
    unicode:characters_to_list(Bin).