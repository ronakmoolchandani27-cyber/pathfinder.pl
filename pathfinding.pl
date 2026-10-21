% connected (node1, node2, Disance/cost)
connected(a, b, 2).
connected(a, c, 5).
connected(b, d, 3).
connected(b, e, 7).
connected(c, f, 1).
connected(d, f, 4).
connected(e, g, 2).
connected(f, g, 6).

% heuristic estimates h(n) from node to goal state 'g'
heuristic(a, 10).
heuristic(b, 8).
heuristic(c, 7).
heuristic(d, 5).
heuristic(e, 2).
heuristic(f, 4).
heuristic(g, 0).

%dfs(Currentnode, goalnode, visitedlist, pathresult)
dfs(Goal, Goal, _, [Goal]).
dfs(Current, Goal, Visited, [Current|Path]) :-
    connected(Current, Next, _),
    \+ member(Next, Visited),
    dfs(Next, Goal, [Next|Visited], Path).


bfs(Start, Goal, Path) :-
    bfs_queue([[Start]], Goal, Path).

bfs_queue([[Goal|Path]|_], Goal, FinalPath) :- 
    reverse([Goal|Path], FinalPath).
bfs_queue([[Current|Path]|Queue], Goal, FinalPath) :-
    findall([Next, Current|Path],
            (connected(Current, Next, _), \+ member(Next, Path)),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    bfs_queue(UpdatedQueue, Goal, FinalPath).


% A* Queue Element Format: [F_Score, G_Score, CurrentNode | PathToNode]
astar(Start, Goal, Path) :-
    heuristic(Start, H),
    astar_queue([[H, 0, Start]], Goal, [], Path).

astar_queue([[_, _, Goal | Path] | _], Goal, _, FinalPath) :-
    reverse([Goal|Path], FinalPath).
astar_queue([[_, G, Current | Path] | RestQueue], Goal, Visited, FinalPath) :-
    member(Current, Visited), !, % If already visited, skip it
    astar_queue(RestQueue, Goal, Visited, FinalPath).
astar_queue([[_, G, Current | Path] | RestQueue], Goal, Visited, FinalPath) :-
    findall([F_Next, G_Next, Next, Current | Path],
            (connected(Current, Next, Cost),
             \+ member(Next, Path),
             G_Next is G + Cost,
             heuristic(Next, H_Next),
             F_Next is G_Next + H_Next),
            NewBranches),
    append(RestQueue, NewBranches, CombinedQueue),
    keysort(CombinedQueue, SortedQueue), % Sort elements automatically by F_Score
    astar_queue(SortedQueue, Goal, [Current|Visited], FinalPath).
