% insertion sort implementation with instrumentation 
% insertionSort.m 
function [A, comps, writes] = insertionSort(A, low, high, comps, writes)
    % Sorts subarray from 'low' to 'high' using standard insertion sort.
    %
    % Highly efficient for small datasets ($K \le 32$) due to low constant factor overhead.

    % Outer loop iterates through each element from second to last in the segment
    for i = (low + 1):high
        key = A(i); 
        % writes count for stroing key variables
        writes = writes + 1;
        j = i - 1;

        % inner loop shifts elements to the right until correct insertion
        % spot for (key) is found 
        while j >= low
            % counts key comparisons
            comps = comps + 1;
            if A(j) > key
                A(j + 1) = A(j);
                % counts array writes for shifts
                j = j - 1;
            else
                break;
            end
        end
        A(j + 1) = key;
        %Count array write for final key placement
        writes = writes + 1;
    end 
end