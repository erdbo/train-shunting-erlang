-module(shunt).
-export([compress/1, few/2, find/2]).

compress(Ms) ->
	Ns = rules(Ms),
	if Ns == Ms -> Ms;
	true -> compress(Ns)
end.	

rules(MoveList) ->
	case MoveList of
		[] ->
			[];
		[{_,N}] ->
			case N==0 of
				true -> [];
				false -> MoveList
			end;
		[{A,N},{B,M}|T] ->
			case N==0 of
				true -> [{B,M}|rules(T)];
				false ->
				case A==B of
					true -> rules([{A,(N+M)}|T]);
					false -> [{A,N}|rules([{B,M}|T])]
				end
			end
	end.			

few(Xs, Ys) ->
	case Ys of
		[] ->
			[];
		[Y|T] ->
			 [A|B] = Xs,
		  		 case Y of
		  		 	Y when Y==A ->
		  		 		few(B,T);
		  		 	Y when Y/=A ->
		  		 		{Hs, Ts} = split(Xs, Y),
						{[_|NewXs],_,_} = moves:single({two, -(lists:flatlength(Hs))},
						moves:single({one, -(lists:flatlength(Ts)+1)}, moves:single({two, lists:flatlength(Hs)},
						moves:single({one, lists:flatlength(Ts)+1}, {Xs, [], []})))),
		
						[{one, lists:flatlength(Ts)+1}, {two, lists:flatlength(Hs)},
		 				{one, -(lists:flatlength(Ts)+1)}, {two, -(lists:flatlength(Hs))} | few(NewXs, T)]
		  		 end
	end.

find(Xs, Ys) ->
	case Ys of
		[] ->
			[];
		[Y|T] ->
			{Hs, Ts} = split(Xs, Y),
			{[_|NewXs],_,_} = moves:single({two, -(lists:flatlength(Hs))},
			moves:single({one, -(lists:flatlength(Ts)+1)}, moves:single({two, lists:flatlength(Hs)},
			moves:single({one, lists:flatlength(Ts)+1}, {Xs, [], []})))),
		
			[{one, lists:flatlength(Ts)+1}, {two, lists:flatlength(Hs)},
			 {one, -(lists:flatlength(Ts)+1)}, {two, -(lists:flatlength(Hs))} | find(NewXs, T)]
	end.

split(Xs, Y) ->
	{list:take(Xs, (list:position(Xs, Y)-1)), list:drop(Xs, list:position(Xs, Y))}.