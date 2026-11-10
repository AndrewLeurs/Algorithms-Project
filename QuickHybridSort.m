% Main hybrid sorting driver function 
% HybridQuick.m sort
% implemented QuickHybridSort function to process testing scripts

function [A, comps, writes] = QuickHybridSort(A, K, pivot_rule)
    % Sorts a numeric array using a hybrid Quicksort and Insertion Sort algorithm.
    % 
    % INPUTS:
    %   A - Numeric array to be sorted
    %   K - Non-negative integer threshold (use Insertion Sort when size <= K)
    %   pivot_rule - String specifying pivot selection strategy ('median3' or 'random')
    %
    % OUTPUTS:
    %   A - Sorted array in non-decreasing order
    %   comps - Total number of element comparisons performed
    %   writes - Total number of array write/swap operations performed

    % Initializes metric counters
    comps = 0; 
    writes = 0; 

    % edge case if array has 0 or 1 element, it is already sorted Retruns
    % immediately
    if length(A) <= 1
        return;
    end

    % recursive core sorting engine
    [A, comps, writes] = hybridSortRecursive(A, 1, length(A), K, pivot_rule, comps, writes);
end

function [A, comps, writes] = hybridSortRecursive(A, low, high, K, pivot_rule, comps, writes)
        % recursively partitions large subarrays 
        % 
        % utilizes an iterative - recursive hybrid loop to prevent stack
        % overflow on large inputs 
        %

        while (high - low) > K 
            % partitions the current subarray around a pivot using Hoare's
            % scheme
            [A, pIndex, comps, writes] = hoarePartition(A, low, high, pivot_rule, comps, writes);

            % tail-recursion optimization - determines smaller partition to
            % recurse immediately 
            if (pIndex - low) < (high - pIndex) 
                % Left partition is smaller - recures left, loop for right
                % partition 
                [A, comps, writes] = hybridSortRecursive(A, low, pIndex, K, pivot_rule, comps, writes);
                low = pIndex + 1; 
            else
                % right partition is smaller - recurse right, loop for left
                % partition 
                [A, comps, writes] = hybridSortRecursive(A, pIndex + 1, high, K, pivot_rule, comps, writes);
                high = pIndex;
            end
        end

        % Once subarray size drops below or equals threhold K, insertion
        % sort is applied 
        if low < high 
            [A, comps, writes] = insertionSort(A, low, high, comps, writes);
        end
end