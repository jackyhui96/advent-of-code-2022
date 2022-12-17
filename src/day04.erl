-module(day04).
-export([p1/0, p2/0]).

-record(assignment, { 
    start_id :: integer(),
    end_id   :: integer()
}).

p1() ->
    String = advent:input("d04"),
    AssignmentGroups = [
        begin
           [First, Second] = string:split(Line, ","),
           {new_assignment(First), new_assignment(Second)}
        end || Line <- string:split(String, "\n", all)],
    FullOverlappedGroup = [AG || AG = {First, Second} <- AssignmentGroups, full_overlap(First, Second)],
    length(FullOverlappedGroup).

p2() ->
    String = advent:input("d04"),
    AssignmentGroups = [
        begin
           [First, Second] = string:split(Line, ","),
           {new_assignment(First), new_assignment(Second)}
        end || Line <- string:split(String, "\n", all)],
    SomeOverlap =
        fun(X, Y) ->
            full_overlap(X, Y) orelse half_overlap(X, Y)
        end,
    OverlappedGroup = [AG || AG = {First, Second} <- AssignmentGroups, SomeOverlap(First, Second)],
    length(OverlappedGroup).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

new_assignment(String) ->
    [StartId, EndId] = string:split(String, "-"),
    #assignment{start_id = list_to_integer(StartId), end_id = list_to_integer(EndId)}.

full_overlap(#assignment{start_id = S1, end_id = E1}, #assignment{start_id = S2, end_id = E2}) ->
    case lists:sort([S1, E1, S2, E2]) of
        [S1, _, _, E1] -> true;
        [S2, _, _, E2] -> true;
        _ -> false
    end.

half_overlap(#assignment{start_id = S1, end_id = E1}, #assignment{start_id = S2, end_id = E2}) ->
    case lists:sort([S1, E1, S2, E2]) of
        [S1, _, E1, _] -> true;
        [_, S1, _, E1] -> true;
        [S2, _, E2, _] -> true;
        [_, S2, _, E2] -> true;
        _ -> false
    end.
