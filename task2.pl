isPokemon(pikachu).
isPokemon(noctowl).
isPokemon(abra).
isPokemon(pig).
isPokemon(zangoose).
isPokemon(lottad).
isPokemon(ponyta).
isPokemon(torchic).
isPokemon(shellder).
isPokemon(cloyster).
isPokemon(sawk).
isPokemon(snover).
isPokemon(meowth).
isPokemon(blastoi).
isPokemon(seel).
isPokemon(onix).
isPokemon(skorupi).
isPokemon(slowpoke).
isPokemon(rhyhorn).
isPokemon(axew).
isPokemon(zubat).
isPokemon(koffing).
isPokemon(pineco).
isPokemon(yanma).
isPokemon(roselia).

color(roselia, green).
color(yanma, red).
color(pineco, green).
color(koffing, purple).
color(zubat, blue).
color(axew, green).
color(rhyhorn, grey).
color(slowpoke, pink).
color(skorupi, purple).
color(onix, grey).
color(seel, grey).
color(blastoi, blue).
color(meowth, white).
color(snover, white).
color(sawk, blue).
color(cloyster, purple).
color(shellder, purple).
color(torchic, red).
color(ponyta, yellow).
color(lottad, blue).
color(zangoose, white).
color(pikachu,yellow).
color(abra,yellow).
color(noctowl, brown).
color(pig,pink).

combatPower(roselia, 874).
combatPower(yanma, 765).
combatPower(pineco, 459).
combatPower(koffing, 659).
combatPower(zubat, 416).
combatPower(axew, 718).
combatPower(rhyhorn, 982).
combatPower(slowpoke, 228).
combatPower(skorupi, 516).
combatPower(onix, 262).
combatPower(seel,483).
combatPower(blastoi, 516).
combatPower(meowth,14).
combatPower(snover, 12).
combatPower(sawk, 1700).
combatPower(cloyster, 3000).
combatPower(shellder, 10).
combatPower(torchic, 400).
combatPower(ponyta, 1401).
combatPower(lottad, 100).
combatPower(zangoose, 1800).
combatPower(pikachu,1000).
combatPower(abra,50).
combatPower(noctowl,1500).
combatPower(pig,1).

pokemonType(rhyhorn, water).
pokemonType(slowpoke, lazyness).
pokemonType(roselia, grass).
pokemonType(yanma, flying).
pokemonType(pineco, bug).
pokemonType(koffing, poison).
pokemonType(zubat, flying).
pokemonType(axew, dragon).
pokemonType(skorupi, poison).
pokemonType(onix, rock).
pokemonType(seel, water).
pokemonType(blastoi, water).
pokemonType(meowth, normal).
pokemonType(snover, ice).
pokemonType(sawk, fighting).
pokemonType(cloyster, ice).
pokemonType(shellder, water).
pokemonType(torchic, fire).
pokemonType(ponyta, fire).
pokemonType(lottad, grass).
pokemonType(zangoose, fighting).
pokemonType(pig, animal).
pokemonType(pikachu, electric).
pokemonType(abra, electric).
pokemonType(noctowl, flying).

%either casts string to number or return the lower/highest possible bound
myLowCaster(N,S) :-  number_string(N, S).
myLowCaster(N,_) :- N is 0.
myHighCaster(N,S) :-  number_string(N, S).
myHighCaster(N,_) :- N is 5000.
%5000 is max cp here

%just call the predicate. easy peasy
checkIfIsPokemon(A) :- isPokemon(A), writeln("Yes").
checkIfIsPokemon(_) :- writeln("No").

%iterates over all the pokemons with required bounds
bounds(Lb, Ub) :- combatPower(Pokemon, Cp), Cp >Lb, Cp < Ub,write(Pokemon), write(" "), writeln(Cp), fail.
bounds(_,_).

%prints all the pokemons with the entered color
checkcolor(Color) :- color(Pokemon,Color), writeln(Pokemon),fail.
checkcolor(_).
% failure driven loop. Yes i googled that so what look at this lil beauty

%prints all the pokemons with the entered type
checkType(Type) :- pokemonType(Pokemon, Type), writeln(Pokemon), fail.
checkType(_).

%wrapper for checkcolor. Checks whether the base knows the entered color at all and if it does calls the printer
verifyColor(Color) :- color(_,Color),!, checkcolor(Color).
verifyColor(_) :- writeln("no such color").


%wrapper for checktype. Checks whether the base knows the entered type at all and if it does calls the printer 
verifyType(Type) :- pokemonType(_,Type), !, checkType(Type).
verifyType(_) :- writeln("no such type").

% param (<option>, <exitcode>) param handler wrappers

%param("1",C) casts entered name to atom and calls param handler
param("1",C) :- C is 1, writeln("write name for pokemon you want to check"),
    read_string(user_input,"\n","",_, Name) ,atom_string(At, Name), nl, checkIfIsPokemon(At).

%param("2", C) casts entered string to atom and calls param handler
param("2",C) :- C is 1,writeln("write color for pokemon you want to check"),
    read_string(user_input,"\n","",_, Color),atom_string(At, Color), nl, verifyColor(At) .

%param("3", C) casts 2 entered strings to numbers with a bit specified casters. After that calls param handler
param("3",C) :-  C is 1,writeln("write combat Power lower bound "),
    read_string(user_input,"\n","",_, LowerBound),myLowCaster(L1, LowerBound),
    writeln("write combat Power upper bound "),
    read_string(user_input,"\n","",_, UpperBound),myHighCaster(L2, UpperBound), nl,
    bounds(L1, L2).

%param("4", C) casts entered string to atom and calls param handler
param("4",C) :- C is 1, writeln("write type of the pokemon"), 
    read_string(user_input,"\n","",_, Type), atom_string(At, Type),nl, verifyType(At) .

%the only wrapper which sets C to 0 as the there will be no other recursive call of reader
param("exit", C) :- C is 0.

%handler of the wron input
param(_, C) :- writeln("input error"), C is 1.


%reader(C) c is kinda like an exit code. It is set to 0 by param predicate iff the exit command was read
%writes all the options and calls param to choose the param handler wrapper we need 
reader(0) :- writeln("bye!").
reader(1) :- writeln("choose your attribute: "), writeln("1 - is pokemon?"),
    writeln("2 - pokemons with color?"), writeln("3 - show all pokemons with cp bounds"),
    writeln("4 - show all pokemons with entered type"), read_string(user_input,"\n","",_, X), param(X, C), nl, reader(C), !.

% getting started
search :- writeln("hello!"), reader(1).