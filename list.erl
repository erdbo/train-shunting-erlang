-module(list).
-export([take/2, drop/2, append/2, member/2, position/2]).

take(Xs, N) ->
	case N of
		0 ->
			[];
		N ->
			[H|T] = Xs,
			[H|(take(T,(N-1)))] 
	end.

drop(Xs, N) ->
	case N of
		0 ->
			Xs;
		N ->
			[_|T] = Xs,
			drop(T,(N-1)) 
	end.

append(Xs,Ys) ->
    case Xs of
        [] ->
            Ys;
        [H|T] ->
            [H|(append(T,Ys))]
    end.

member(Xs, Y) ->
	case Xs of
		[] ->
			false;
		[Y|_] ->
			true;
		[_|T] ->
			member(T, Y)
	end.

position(Xs, Y) ->
	case Xs of
		[] ->
			0;
		[Y|_] ->
			1;
		[_|T] ->
			1 + position(T, Y)
	end.