-module(day06).
-export([p1/0, p2/0]).

p1() ->
    String = advent:input("d06"),
    find_marker_prime(String, 4).

p2() ->
    String = advent:input("d06"),
    find_marker_prime(String, 14).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

find_marker_prime(String, N) -> find_marker_prime_(String, N, N).
find_marker_prime_(String, N, Count) ->
    Message = lists:sublist(String, N),
    case remove_dups(Message) of
        Message ->
            Count;
        _ -> 
            find_marker_prime_(erlang:tl(String), N, Count+1)
    end.

remove_dups([])    -> [];
remove_dups([H|T]) -> [H | [X || X <- remove_dups(T), X /= H]].

%% Pattern match where we have repetition, initial solution for p1 but not suitable for p2
%% Good example of pattern matching, but shows that it's fixed to looking at 4
% find_marker_legacy([X, X, A, B | Tail], N) -> find_marker_legacy([X, A, B |Tail], N + 1);
% find_marker_legacy([X, A, X, B | Tail], N) -> find_marker_legacy([A, X, B | Tail], N + 1);
% find_marker_legacy([X, A, B, X | Tail], N) -> find_marker_legacy([A, B, X | Tail], N + 1);
% find_marker_legacy([_, X, A, X | Tail], N) -> find_marker_legacy([A, X | Tail], N + 2);
% find_marker_legacy([_, _, X, X | Tail], N) -> find_marker_legacy([X | Tail], N + 3);
% find_marker_legacy([_, X, X, A | Tail], N) -> find_marker_legacy([X, A | Tail], N + 2);
% find_marker_legacy([_, _, _, _ | _], N) -> N.
