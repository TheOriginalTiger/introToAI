cat(butsie). %butsie is cat
cat(cornie). % so is cornie
cat(sam). % and sam
brown(butsie). %butsie is also brown
black(cornie). % while the cornie is black
red(sam). % sam is red(!!!)
red(rover). %same as rover
dog(flash). %  flash is a dog
dog(rover). % rover too
dog(spot). % and spot
white(spot). % spot is white
spotted(flash). % and flash is spotted
ownes(tom, X) :- black(X); brown(X). % tom ownes any pet that is either brown or black
ownes(kate,X) :- dog(X), not(ownes(tom, X)), not(white(X)). % Kate owns all non-white dogs, not belonging to Tom.

