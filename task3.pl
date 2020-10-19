%diagnostic thing

askColor :- writeln("what color is it ?").
isRed(torchik).
isRed(charizard).
isBlue(wailmer).
isBlue(snorlax).
isBlue(honchkrow).
isBlue(butterfree).
isYellow(pikachu).
isYellow(electabuzz).
isGrey(rhydon).
isGrey(onix).
isOrange(raichu).
isBrown(noctowl).
isBrown(dodrio).
isBrown(pinsir).
isBrown(pidgeot).
isPink(slowpoke).
isPink(lickytung).
isPurple(shellder).
isPurple(cloyster).
isPurple(haunter).

askCanWalk :- writeln("does it walk?").
canWalk(torchik).
canWalk(rhydon).
canWalk(slowpoke).
canWalk(snorlax).
askCanSwim :- writeln("does it swim?").
canSwim(wailmer).
canSwim(shellder).
canSwim(cloyster).

askCanRun :- writeln("does it run?").
canRun(pikachu).
canRun(raichu).
canRun(electabuzz).
canRun(dodrio).
canRun(lickytung).

askCanFly :- writeln("does it fly?").
canFly(noctowl).
canFly(charizard).
canFly(honchkrow).
canFly(pidgeot).
canFly(butterfree).
canFly(haunter).

askCanCrowl :- writeln("does it crowl?").
canCrowl(onix).
canCrowl(pinsir).

checkFire :- writeln("does it spit fire?").
isFire(torchik).
isFire(charizard).

checkWater :- writeln("does it pour water?").
isWater(whale).
isWater(rhydon).
isWater(dodrio).
isWater(snorlax).
isWater(shellder).
isWater(cloyster).

checkElectric :- writeln("does it throw lightings?").
isElectric(pikachu).
isElectric(raichu).
isElectric(electabuzz).

checkPhysic :- writeln("does it hit others with brute force?").
isPhysic(noctowl).
isPhysic(slowpoke).
isPhysic(honchkrow).
isPhysic(haunter).
checkStone :- writeln("does it throw stones at ya?").
isStone(onix).
isStone(pidgeot).
isStone(lickytung).

checkBug :- writeln("does it look like a bug?").
isBug(pinsir).
isBug(butterfree).

checkSize :- writeln("can you name the size of it from 1 to 4 (including 4)?").
isTiny(torchik).
isTiny(butterfree).
isTiny(shellder).
isSmall(pikachu).
isSmall(raichu).
isSmall(slowpoke).
isSmall(pinsir).
isSmall(lickytung).
isBig(pidgeot).
isBig(dodrio).
isBig(rhydon).
isBig(electabuzz).
isBig(noctowl).
isBig(haunter).
isGiant(wailmer).
isGiant(snorlax).
isGiant(charizard).
isGiant(honchkrow).
isGiant(onix).
isGiant(cloyster).


% iterates over list of the predicates and tries to find the right
% pokemon.
iter(_,[]) :- !.
iter(X, [H|T]) :- call(H,X) , iter(X,T).

% selector of the predicate. If we are selecting the hard way by just
% asking the question and expecting "yes" or "no", we'll just wait for
% the right predicate to come from the recursive iteration over an array
% if we are doing it the smart way, by expecting a color or a number
% there is a special parses for that.
% The most important part is that this func will always return the
% predicate that is true for the uses' object
verifyAnsw("no", Code,_,_):- Code is 1,!.
verifyAnsw("yes", Code, A, A) :- Code is 0,!.
verifyAnsw("blue", Code, _, isBlue) :- Code is 0,!.
verifyAnsw("red", Code, _, isRed) :- Code is 0,!.
verifyAnsw("brown", Code, _, isBrown) :- Code is 0,!.
verifyAnsw("yellow", Code, _, isYellow) :- Code is 0,!.
verifyAnsw("orange", Code, _, isOrange) :- Code is 0,!.
verifyAnsw("pink", Code, _, isPink) :- Code is 0,!.
verifyAnsw("purple", Code, _, isPurple) :- Code is 0,!.
verifyAnsw("grey", Code, _, isGrey) :- Code is 0,!.
verifyAnsw("1", Code, _, isTiny) :- Code is 0,!.
verifyAnsw("2", Code, _, isSmall) :- Code is 0,!.
verifyAnsw("3", Code, _, isBig) :- Code is 0,!.
verifyAnsw("4", Code, _, isGiant) :- Code is 0,!.

verifyAnsw(_, Code, _, none) :- Code is 0,!.

% parses and array. Splits each pair and asks the user whether the
% predicate is true for the object he diagnoses
parseAttr([], _, none) :- !.
parseAttr(_,0,_) :- !.
parseAttr([[A,Q]|T], 1, V) :- call(Q), read_string(user_input,"\n","",_, Answ),
                           verifyAnsw(Answ,Code,A,V), parseAttr(T,Code,V).

% splits the global array and feeds the innerArrayParser with inner
% arrays. As the result we'll have an array of the attrs
parseAttrs([],R,R).
parseAttrs([H|T],List,R) :- parseAttr(H,1,V), append([V], List, Result), parseAttrs(T,Result,R).


% so the idea of the whole diagnose system is simple. Lets consider some
% attributes of the object. Can we name some of them that actually
% exclude others? Yes, usually we can. For example, if animal has a fur
% it can't have a fin. And so on. Lets unite those excluding attributes
% into the arrays and put them into one array of arrays. Then we need to
% iterate over each array and select a single attribute that exclude
% others in the same array. As the result we'll have an array of
% attributes that describes an object. Lets hope it is the only one and
% also it exists :p (though the sys does treat those cases right!)

% init func prepares the array of arrays to be filtered. Take a look at
% the arrays themself. For example, we dont actually need to ask the
% user about each color every time. It will definitly look wrong, so it
% is much easier to ask about the color in general and let the sys treat
% it correctly. Also take a closer look at the elements of the inner
% arrays. They are arrays as well! Well, not arrays, but pairs. Each
% element of the inner array is the pair of predicat attr and predicat,
% asking the user whether the predicate is true for the object he is
% diagnosing.
init(V) :- parseAttrs([
            [
                [isRed,askColor]
            ],
            [
                [canFly,askCanFly],[canCrowl ,askCanCrowl ],[canRun, askCanRun], [canWalk, askCanWalk]
            ],
            [
                [isFire, checkFire], [isWater, checkWater], [isElectric,checkElectric], [isPhysic , checkPhysic],
                [isStone, checkStone], [isBug, checBug]
            ],
            [
                [isTiny, checkSize]
            ]
           ],[],V
         ).

iterwrapper("uknown pokemon. You are about to be the first one to catch it !",V) :- member(none, V),!.
iterwrapper(X,V) :- iter(X,V),!.
iterwrapper("uknown pokemon. You are about to be the first one to catch it!",_).


%main func to call.
consult :- writeln("Hello! Is there an unknown pokemon in front of you?"),writeln("If there is I'm ready to assist you in identifying it!"),
    writeln("I will ask you a few questions about the pokemon you see and tell you what it is!"),
    init(V), iterwrapper(X,V),writeln("thats simple, its:"), writeln(X),!.
