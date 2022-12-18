-module(day05).
-export([p1/0, p2/0]).

-record(step, {
    amount :: integer(),
    from   :: integer(),
    to     :: integer()
}).

p1() ->
    String = advent:input("d05"),
    [CrateString, StepsString] = string:split(String, "\n\n"),
    CrateMap = new_crates(CrateString),
    Steps = new_steps(StepsString),
    NewCrateMap = lists:foldl(move_stack(false), CrateMap, Steps),
    head_of_stacks(NewCrateMap).

p2() ->
    String = advent:input("d05"),
    [CrateString, StepsString] = string:split(String, "\n\n"),
    CrateMap = new_crates(CrateString),
    Steps = new_steps(StepsString),
    NewCrateMap = lists:foldl(move_stack(true), CrateMap, Steps),
    head_of_stacks(NewCrateMap).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

new_crates(String) ->
    CrateRows0 =  string:split(String, "\n", all),
    NumRows = length(CrateRows0) - 1,
    CrateRows = lists:sublist(CrateRows0, NumRows),
    new_crates(CrateRows, 1, #{}).

new_crates([[] | _], _, AccMap) ->
    AccMap;
new_crates(CrateRows, Col, AccMap) ->
    NewRows0 = [parse_row(Row) || Row <- CrateRows],
    Stack = [Crate || {Crate, _} <- NewRows0, Crate =/= empty],
    NewRows = [Tail || {_, Tail} <- NewRows0],
    NewAccMap = AccMap#{Col => Stack},
    new_crates(NewRows, Col+1, NewAccMap).

parse_row([$[, Char, $], $ | Tail]) -> {Char, Tail};
parse_row([$[, Char, $]]) -> {Char, []};
parse_row("    " ++ Tail) -> {empty, Tail};
parse_row("   ") -> {empty, []}.

new_steps(StepsString) ->
    Steps = string:split(StepsString, "\n", all),
    new_steps_(Steps).

new_steps_([]) ->
    [];
new_steps_([StepRow | StepRows]) ->
    ["move", N, "from", From, "to", To] = string:split(StepRow, " ", all),
    [#step{amount = list_to_integer(N), from = list_to_integer(From), to = list_to_integer(To)} | new_steps_(StepRows)].

move_stack(KeepOrder) ->
    StackFun =
        case KeepOrder of
            true -> fun lists:append/2;
            false -> fun stack_one_by_one/2
        end,
    fun(#step{amount = N, from = From, to = To}, CrateMap) ->
        #{From := FromStack, To := ToStack} = CrateMap,
        {NCrates, NewFromStack} = lists:split(N, FromStack),
        CrateMap#{From => NewFromStack, To => StackFun(NCrates, ToStack)}
    end.

stack_one_by_one([], List) -> List;
stack_one_by_one([H | T], List) -> stack_one_by_one(T, [H | List]).

head_of_stacks(CrateMap) ->
    [H || {_, [H | _T]}<- maps:to_list(CrateMap)].
