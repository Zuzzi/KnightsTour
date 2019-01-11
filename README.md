How can a knight jump on an NxN chessboard in such a way that it visits  every square exactly once?
input: dimension N of the board and starting Tile
 output: List of squares which completes the knight's tour
 The main predicate builds a list of NxN coordinates, delete the
 starting position from the list and call the depth first search
 algorithm to find a possible solution, then it prints the solution
 list on the screen

 e.g.
 ?- knightstour(5,1/5,Tour).
 THE TOUR IS ----> 1/5 3/4 5/5 4/3 3/5 5/4
