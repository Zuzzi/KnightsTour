% Knight's tour! by Carlo Peroni
%
% How can a knight jump on an NxN chessboard in such a way that it visits
% every square exactly once?
%
% input: dimension N of the board and starting Tile
% output: List of squares which completes the knight's tour
% The main predicate builds a list of NxN coordinates, delete the
% starting position from the list and call the depth first search
% algorithm to find a possible solution, then it prints the solution
% list on the screen
%
% e.g.
% ?- knightstour(5,1/5,Tour).
% THE TOUR IS ----> 1/5 3/4 5/5 4/3 3/5 5/4
% 4/2 2/1 1/3 2/5 4/4 5/2 3/3 1/4 2/2 4/1 5/3 4/5 2/4 1/2 3/1 2/3 1/1
% 3/2 5/1

knightstour(N,Position,Tour) :-
    build_list(N,1,1,To_visit),
    delete(To_visit,Position,To_visit1),
    dfs(N,Position,Tour,To_visit1),
    nl(),
    write(' THE TOUR IS ---->  '),
    print_list(Tour).

dfs(_,Tile,[Tile],[]).
dfs(N,Tile,[Tile|Tail],To_visit) :-
    jump(N,Tile,X1/Y1,To_visit),
    delete(To_visit,X1/Y1,To_visit1),
    dfs(N,X1/Y1,Tail,To_visit1).

% Jump is the successor relation for the depth first searh algorithm.
% It is possible to jump from X/Y to X1/Y1 only if:
% 1) X/Y is inside the NxN board
% 2) X/Y -> X1/Y1 is a legal move of the knight for the western chess
% rules
% 3) The final position X1/Y1 is inside the NxN board
%
% Legend:
% O -> empty squares
% X -> Knight's position
% a,b,c,d,e,f,g,h -> possible next position
%
% 5  O a O b O
% 4  h O O O c
% 3  O O X O O
% 2  g O O O d
% 1  O f O e O
%
%    1 2 3 4 5
%
%
% N.B.
% Delete the write() and nl() instructions from the jump relation to
% speed up the search algorithm
%

jump(N,X/Y,X1/Y1,To_visit) :-
    in_board(N,X/Y),
    allowed(X/Y,X1/Y1),
    in_board(N,X1/Y1),
    member(X1/Y1,To_visit),
    write(' jump from '),
    write(X/Y),
    write(' to '),
    write(X1/Y1),
    nl().

in_board(N,X/Y) :-
    N > 0,
    X > 0,
    Y > 0,
    X =< N,
    Y =< N.

%case a
allowed(X/Y,X1/Y1) :-
    X1 is X-1,
    Y1 is Y+2.

%case b
allowed(X/Y,X1/Y1) :-
    X1 is X+1,
    Y1 is Y+2.

%case c
allowed(X/Y,X1/Y1) :-
    X1 is X+2,
    Y1 is Y+1.

%case d
allowed(X/Y,X1/Y1) :-
    X1 is X+2,
    Y1 is Y-1.

%case e
allowed(X/Y,X1/Y1) :-
    X1 is X+1,
    Y1 is Y-2.

%case f
allowed(X/Y,X1/Y1) :-
    X1 is X-1,
    Y1 is Y-2.

%case g
allowed(X/Y,X1/Y1) :-
    X1 is X-2,
    Y1 is Y-1.

%case h
allowed(X/Y,X1/Y1) :-
    X1 is X-2,
    Y1 is Y+1.

% The next predicates are utility to build the list of X/Y coordinates
% (used to take track of the squares the knight still needs to visit)
% and to print it on the screen

build_list(N,N1,_,[]) :-
    N1 is N+1.
build_list(N,X,Y,L) :-
    X =< N,
    Y =< N,
    fill_y_elements(N,X,Y,L1),
    X1 is X+1,
    build_list(N,X1,Y,L2),
    concat_lists(L1,L2,L).

fill_y_elements(N,X,N,[X/N]).
fill_y_elements(N,X,Y,[X/Y|Tail]) :-
    Y =< N,
    Y1 is Y+1,
    fill_y_elements(N,X,Y1,Tail).

concat_lists([],L2,L2).
concat_lists([T1|C1],L2,[T1|L3]) :-
    concat_lists(C1,L2,L3).

print_list([]).
print_list([T|C]) :-
    write(T),
    write(' '),
    print_list(C).
