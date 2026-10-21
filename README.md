## 🖥️ How to Run & Expected Execution Output

To view the comparison, load the file into your SWI-Prolog compiler and execute the test runner:

```prolog
?- run_all.
```

### 📊 Performance Results Report
When you execute the query above, the system evaluates the graph and prints the following comparative terminal summary:

```text
--- AI PATHFINDING SIMULATION REPORT ---
DFS Found Path : [a, b, e, g]
BFS Found Path : [a, b, e, g]
A* Found Path  : [a, b, d, f, g]
----------------------------------------
```

### 🧠 Algorithmic Observations
1. **DFS & BFS** both found the path `[a, b, e, g]`. They traverse the graph structurally without tracking edge weights, stopping as soon as they hit the goal node.
2. **A\* Search** intelligently calculated the true movement costs (g) along with the heuristic estimates (h). It discovered that diving down to node `e` is an expensive detour, routing instead through `[a, b, d, f, g]` to achieve the actual lowest-cost path.
