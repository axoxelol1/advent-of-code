-module(day04).
-export([day04/0]).

part1() ->
    {ok, Data} = file:read_file("input.txt"),
    Input = string:trim(Data),
    loop(Input, 0).

loop(Inp, Iter) ->
    Iterbin = integer_to_binary(Iter),
    Res = crypto:hash(md5, <<Inp/binary, Iterbin/binary>>),
    <<A, B, C, _/binary>> = Res,
    case (A == 0) andalso (B == 0) andalso (C < 16) of
        true -> Iter;
        false -> loop(Inp, Iter + 1)
    end.

part2() ->
    {ok, Data} = file:read_file("input.txt"),
    Input = string:trim(Data),
    loop2(Input, 0).

loop2(Inp, Iter) ->
    Iterbin = integer_to_binary(Iter),
    Res = crypto:hash(md5, <<Inp/binary, Iterbin/binary>>),
    <<A, B, C, _/binary>> = Res,
    case (A == 0) andalso (B == 0) andalso (C == 0) of
        true -> Iter;
        false -> loop2(Inp, Iter + 1)
    end.


day04() -> io:fwrite("~p~n", [part1()]),
           io:fwrite("~p~n", [part2()]).
