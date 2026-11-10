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
 
function [A, j, comps, writes] = hoarePartition(A, low, high, pivot_rule, comps, writes)
    % Partitions array segment between 'low' and 'high' using Hoare's two-pointer scheme.
    %
    % EXPLANATION:
    % Scans inward from both ends, swapping elements only when both pointers find items 
    % misplaced relative to the pivot. This drastically minimizes array writes.

    % Select pivot index based on user specification
    if strcmpi(pivot_rule, 'median3')
        [pivotIndex, comps] = getMedian3Pivot(A, low, high, comps);
    elseif strcmpi(pivot_rule, 'random')
        pivotIndex = randi([low, high]);
    else
        pivotIndex = low;
    end

    % moves chosen pivot to the starting postion for partioning 
    temp = A(low);
    A(low) = A(pivotIndex);
    A(pivotIndex) = temp;
    % two writes for the pivot swap
    writes = writes + 2; 

    pivot = A(low);
    % Count comparison for establiching pivot value 
    comps = comps + 1;

    i = low - 1; 
    j = high + 1;

    % Main partition loop scanning inward 
    while true 
        % scans right pointer (i) upward until element >= pibot is found 
        while true
            i = i + 1; 
            % counts key comparisons 
            comps = comps + 1 ;
            if A(i) >= pivot
                break;
            end
        end

        % scans left pointer (j) downward until element <= pivot is found
        while true 
            j = j - 1;
            % counts key comparisons 
            comps = comps + 1; 
            if A(j) <= pivot
                break;
            end 
        end

        % if pointers cross or meet, partitioning of this segment is
        % complete 
        if i >= j
            break;
        end

        % swapsmisplaced elements at index (i) and (j)
        temp = A(i);
        A(i) = A(j);
        A(j) = temp;
        % two writes for swapping elements 
        writes = writes + 2; 
    end
end