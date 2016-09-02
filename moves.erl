-module(moves).
-export([single/2, move/2]).

single({one, N}, {Main, One, Two}) ->
	case N of
		N when N>0  ->
			{list:take(Main, lists:flatlength(Main)-N), list:append(list:drop(Main, lists:flatlength(Main)-N), One), Two};
		N when N<0 ->
			{list:append(Main, list:take(One, N*-1)), list:drop(One,N*-1), Two};
		N when N==0 ->
			{Main, One, Two}
	end;

single({two, N}, {Main, One, Two}) ->
	case N of
		N when N>0  ->
			{list:take(Main, lists:flatlength(Main)-N), One, list:append(list:drop(Main, lists:flatlength(Main)-N), Two)};
		N when N<0 ->
			{list:append(Main, list:take(Two, N*-1)), One, list:drop(Two, N*-1)};
		N when N==0 ->
			{Main, One, Two}
	end.

move(MoveList, State) ->
	case MoveList of
		[] -> 
			[State | []];
		[H|T] ->
			[State | (move(T, (single(H, State))))]
	end.