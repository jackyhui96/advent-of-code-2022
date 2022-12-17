-module(day02).
-export([p1/0, p2/0]).

p1() ->
    String = advent:input("d02"),
    Rounds = string:split(String, "\n", all),
    Scores = [
        begin
            [Code1, Code2] = string:split(R, " "),
            score_round(decode_letter(Code1), decode_letter(Code2))
        end || R <- Rounds],
    lists:sum(Scores).

p2() ->
    String = advent:input("d02"),
    Rounds = string:split(String, "\n", all),
    Scores = [
        begin
            [Code1, Code2] = string:split(R, " "),
            {OpponentHand, MyHand} = decode_round(Code1, Code2),
            score_round(OpponentHand, MyHand)
        end || R <- Rounds],
    lists:sum(Scores).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

decode_letter("A") -> rock;
decode_letter("B") -> paper;
decode_letter("C") -> scissor;
decode_letter("X") -> rock;
decode_letter("Y") -> paper;
decode_letter("Z") -> scissor.

decode_round(Code1, Code2) ->
    Hands = [rock, paper, scissor],
    DesiredOutcome =
        case Code2 of
            "X" -> lose;
            "Y" -> draw;
            "Z" -> win
        end,
    OpponentHand = decode_letter(Code1),
    [MyHand] = [H || H <- Hands, rock_paper_scissor(OpponentHand, H) =:= DesiredOutcome],
    {OpponentHand, MyHand}.

score_round(OpponentHand, MyHand) -> 
    Outcome = rock_paper_scissor(OpponentHand, MyHand),
    calc_score(Outcome) + calc_score(MyHand).

calc_score(rock) -> 1;
calc_score(paper) -> 2;
calc_score(scissor) -> 3;
calc_score(lose) -> 0;
calc_score(draw) -> 3;
calc_score(win) -> 6.

rock_paper_scissor(_OpponentHand = rock, _MyHand = rock) -> draw;
rock_paper_scissor(_OpponentHand = rock, _MyHand = paper) -> win;
rock_paper_scissor(_OpponentHand = rock, _MyHand = scissor) -> lose;
rock_paper_scissor(_OpponentHand = paper, _MyHand = rock) -> lose;
rock_paper_scissor(_OpponentHand = paper, _MyHand = paper) -> draw;
rock_paper_scissor(_OpponentHand = paper, _MyHand = scissor) -> win;
rock_paper_scissor(_OpponentHand = scissor, _MyHand = rock) -> win;
rock_paper_scissor(_OpponentHand = scissor, _MyHand = paper) -> lose;
rock_paper_scissor(_OpponentHand = scissor, _MyHand = scissor) -> draw.
