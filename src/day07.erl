-module(day07).
-export([p1/0, p2/0]).
% -compile([export_all, {nowarn, export_all}]).

p1() ->
    String = advent:input("d07"),
    ok.

p2() ->
    String = advent:input("d07"),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

eg() ->
    "$ cd /\n"
    "$ ls\n"
    "dir a\n"
    "14848514 b.txt\n"
    "8504156 c.dat\n"
    "dir d\n"
    "$ cd a\n"
    "$ ls\n"
    "dir e\n"
    "29116 f\n"
    "2557 g\n"
    "62596 h.lst\n"
    "$ cd e\n"
    "$ ls\n"
    "584 i\n"
    "$ cd ..\n"
    "$ cd ..\n"
    "$ cd d\n"
    "$ ls\n"
    "4060174 j\n"
    "8033020 d.log\n"
    "5626152 d.ext\n"
    "7214296 k".