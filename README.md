# Algorithms Project
---
## Environment and System Specifications
* **Programming Language:** MATLAB R2025b & R2026b
* **Required Libraries/ToolBoxes:** None Base MATLAB functionality was used; no additional tools required
* **Fixed Random Seed** `3364` (ensures reproducible trial generation.

---

## Part 1
- Implement QuickHybridSort(A, K, pivot_rule)
- Use Hoare's partition (familiarity & efficiency compared to Lomuto)
- Median-of-3 pivot rule

 
###  Main hybrid sorting driver function 
* **HybridQuick.m sort** combines **Quicksort** for large sub-arrays with **Insertion Sort**
* **Pivot Selection:** **Median-of-Three** `median3` pivot selection accross left, middle, and right elements 
* with `random` for comparisons.

### Partition Function 
**(Lomuto or Hoare) 
Partitiong Comparison(s)**

**Lomuto**: Uses a single pointer (i) starting before the subarray
and a scanning pointer (j) which moves from the left boundary up to the 
second-to-last emelent. If an element at (j) is less than or equal
to the pivot, (i) is incremented, and the lements at (i) and (j) are swapped.
Finally, the pivot is placed into its correct sorted position by swapping it
with (i + 1)

**reference**: https://www.geeksforgeeks.org/dsa/lomuto-partition-algorithm/

**Hoare**: Uses two pointer (i) which moves right from the start, 
and (j) which moves left from the end. The pointer scan inward stopping 
whin (i) finds an element greater than or equal to the pivot and (j) finds 
an element less than or equal to the pivot. If (i < j) the elements are swapped
this process will repeat itself until the pointers cross. 

**reference**: https://www.geeksforgeeks.org/dsa/hoare-s-partition-algorithm/

because Hoare minimizes redundant swaps and handles duplicates more efficiently
we chose to use Hoare partitioning. 

### partitioning logic with explicit intstrumentation 
* **hoarePartition.m** performs fewer swaps/writes and handles duplicate elements better than Lomuto

### Sorting functions must count
**Comparisons**: Element-to-element key comparisons used by partitoning, 
median-of-three selection, and insertion sort (not loop-bound or index checks)

**Moves/Writes**: Writes to arry positions; a swap of two different positions
counts as two writes. exchanges with the same position are not

### Part 1 files
* `QuickHybridSort.m` - Main hybrid sorting driver (`QuickHybridSort(A, K, pivot_rule)`)
* `hoarePartition.m` - Hoare partitioning helper with comparison and write implementation
* `getMedian3Pivot.m` - median-of-three pivot index selection 
* `insersionSort.m` - Insertion sort implementation with comparison and write implementation
* `runExperiments.m` - benchmark and experiment driver script for trials, data collection and plot generation

---

## Part 2 Planet Zorb
---------------------------------
### Bottom-up 0/1 knapsack implementation and traceback logic 
* **`knapsackDP.m`** - Bottom-up  0/1 knapsack DP implementaion, single solution and entire solution enumeration 

---


### Commands for testing/experiments: 

Open MATLAB in project directory and run: 
# Part 1
* **runExperiments;**

# Part 2
* **[maxScore, optimalSets] = knapsackDP;** 