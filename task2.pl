isPokemon(pikachu).
isPokemon(noctowl).
isPokemon(abra).
isPokemon(pig).

color(pikachu,yellow).
color(abra,yellow).
color(noctowl, brown).
color(pig,pink).
combatPower(pikachu,100).
combatPower(abra,50).
combatPower(noctowl,100).
combatPower(pig,1).


myLowCaster(N,S) :-  number_string(N, S).
myLowCaster(N,_) :- N is 0.
myHighCaster(N,S) :-  number_string(N, S).
myHighCaster(N,_) :- N is 5000.
%5000 is max cp here

checkIfIsPokemon(A) :- isPokemon(A), writeln("Yes").
checkIfIsPokemon(_) :- writeln("No").

bounds(Lb, Ub) :- combatPower(Pokemon, Cp), Cp >Lb, Cp < Ub,write(Pokemon), write(" "), writeln(Cp), fail.
bounds(_,_).

checkcolor(Color) :- color(Pokemon,Color), writeln(Pokemon),fail.
checkcolor(_).
% failure driven loop. Yes i googled that so what look at this lil beauty

param("1",C) :- C is 1, writeln("write name for pokemon you want to check"),
    read_string(user_input,"\n","",_, Name) ,atom_string(At, Name),checkIfIsPokemon(At).

param("2",C) :- C is 1,writeln("write color for pokemon you want to check"),
    read_string(user_input,"\n","",_, Color),atom_string(At, Color),checkcolor(At) .

param("3",C) :-  C is 1,writeln("write combat Power lower bound "),
    read_string(user_input,"\n","",_, LowerBound),myLowCaster(L1, LowerBound),
    writeln("write combat Power upper bound "),
    read_string(user_input,"\n","",_, UpperBound),myHighCaster(L2, UpperBound),
    bounds(L1, L2).

param("exit", C) :- C is 0.

param(_, C) :- writeln("wrong attr"), C is 1.


reader(0) :- writeln("bye!").
reader(1) :- writeln("choose your attribute: "), writeln("1 - is pokemon?"),
    writeln("2 - pokemons with color?"), writeln("3 - show all pokemons with cp bounds"),read_string(user_input,"\n","",_, X), param(X, C), reader(C),!.

search :- writeln("hello!"), reader(1).% getting in
