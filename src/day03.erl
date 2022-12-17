-module(day03).
-export([p1/0, p2/0]).

-record(rucksack, { 
    first :: list(),
    second :: list()
}).

-record(group, { 
    first :: list(),
    second :: list(),
    third :: list()
}).

p1() ->
    String = advent:input("d03"),
    Rucksacks = [new_rucksack(Line) || Line <- string:split(String, "\n", all)],
    lists:sum([priority(shared_item(Rucksack)) || Rucksack <- Rucksacks]).

p2() ->
    String = advent:input("d03"),
    Rucksacks = string:split(String, "\n", all),
    Groups = new_groups(Rucksacks), 
    lists:sum([priority(shared_item(Group)) || Group <- Groups]).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

new_rucksack(String) ->
    CompartmentSize = length(String) div 2,
    {First, Second} = lists:split(CompartmentSize, String),
    #rucksack{first = First, second = Second}.

new_groups([]) ->
    [];
new_groups([First, Second, Third | String]) ->
    [#group{first = First, second = Second, third = Third} | new_groups(String)].


shared_item(#rucksack{first = First, second = Second}) ->
    [SharedItem] = lists:usort([F || F <- First, lists:member(F, Second)]),
    SharedItem;
shared_item(#group{first = First, second = Second, third = Third}) ->
    [SharedItem] = lists:usort([F || F <- First, lists:member(F, Second) andalso lists:member(F, Third)]),
    SharedItem.

priority(Item) when Item >= $a andalso Item =< $z -> Item - $a + 1;
priority(Item) when Item >= $A andalso Item =< $Z -> Item - $A + 27.
