-module(day01).
-export([p1/0, p2/0]).

p1() ->
    String = advent:input("d01"),
    [TopCalorieElf | _] = sum_calorie_of_elves(String),
    TopCalorieElf.

p2() ->
    String = advent:input("d01"),
    SortedElvesWithTotalCalorieCount = sum_calorie_of_elves(String),
    Top3Elves = lists:sublist(SortedElvesWithTotalCalorieCount, 3),
    lists:sum(Top3Elves).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

sum_calorie_of_elves(String) ->
    Elves = string:split(String, "\n\n", all),
    ElvesWithCalorieCount = [
        begin
            [begin
                list_to_integer(FoodCalorie)
             end || FoodCalorie <- string:split(Elf, "\n", all)]
        end || Elf <- Elves],
    ElvesWithTotalCalorieCount = [lists:sum(E) || E <- ElvesWithCalorieCount],
    SortedElvesWithTotalCalorieCount = lists:sort(ElvesWithTotalCalorieCount),
    lists:reverse(SortedElvesWithTotalCalorieCount).
