% Partition Function 
% - (Lomuto or Hoare) 
% Partitiong Comparison(s)
% 
% Lomuto: Uses a single pointer (i) starting before the subarray
% and a scanning pointer (j) which moves from the left boundary up to the 
% second-to-last emelent. If an element at (j) is less than or equal
% to the pivot, (i) is incremented, and the lements at (i) and (j) are swapped.
% Finally, the pivot is placed into its correct sorted position by swapping it
% with (i + 1)

% reference: https://www.geeksforgeeks.org/dsa/lomuto-partition-algorithm/

% Hoare: Uses two pointer (i) which moves right from the start, 
% and (j) which moves left from the end. The pointer scan inward stopping 
% whin (i) finds an element greater than or equal to the pivot and (j) finds 
% an element less than or equal to the pivot. If (i < j) the elements are swapped
% this process will repeat itself until the pointers cross. 

% reference: https://www.geeksforgeeks.org/dsa/hoare-s-partition-algorithm/

% because Hoare minimizes redundant swaps and handles duplicates more efficiently
% we chose to use Hoare partitioning. 

% partitioning logic with explicit intstrumentation 
% hoarePartition.m
 