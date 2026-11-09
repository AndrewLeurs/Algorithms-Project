Algorithms Project
-----------------------
Part 1
- Implement QuickHybridSort(A, K, pivot_rule)
- Use Hoare's partition (familiarity & efficiency compared to Lomuto)
- Median-of-3 pivot rule


Programming langugae: MATLAB R2025b 
Device specifications: 

Commands for testing/experiments: 

Functions: 
 
###  Main hybrid sorting driver function 
1. HybridQuick.m sort

### insertion sort implementation with instrumentation 
2. insertionSort.m 
### Partition Function 
- (Lomuto or Hoare) 
Partitiong Comparison(s)
1. Lomuto: Uses a single pointer (i) starting before the subarray
and a scanning pointer (j) which moves from the left boundary up to the 
second-to-last emelent. If an element at (j) is less than or equal
to the pivot, (i) is incremented, and the lements at (i) and (j) are swapped.
Finally, the pivot is placed into its correct sorted position by swapping it
with (i + 1)

reference: https://www.geeksforgeeks.org/dsa/lomuto-partition-algorithm/

2. Hoare: Uses two pointer (i) which moves right from the start, 
and (j) which moves left from the end. The pointer scan inward stopping 
whin (i) finds an element greater than or equal to the pivot and (j) finds 
an element less than or equal to the pivot. If (i < j) the elements are swapped
this process will repeat itself until the pointers cross. 

reference: https://www.geeksforgeeks.org/dsa/hoare-s-partition-algorithm/

because Hoare minimizes redundant swaps and handles duplicates more efficiently
we chose to use Hoare partitioning. 

### partitioning logic with explicit intstrumentation 
4. hoarePartition.m
 
### Median-of-three pivot selection helper
5. getMedian3Pivot.m
### Script to execute and gather metrics/generate plots 
6. runExperiments.m 

### bottom-up 0/1 knapsack implementation and traceback logic 
7. knapsackDP.m 

Sorting functions must count
1. Comparisons: Element-to-element key comparisons used by partitoning, 
median-of-three selection, and insertion sort (not loop-bound or index checks)

2. Moves/Writes: Writes to arry positions; a swap of two different positions
counts as two writes. exchanges with the same position are not

