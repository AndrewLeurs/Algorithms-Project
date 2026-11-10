% Median-of-three pivot selection helper
% getMedian3Pivot.m
 
function [pivotIndex, comps] = getMedian3Pivot(A, low, high, comps)
    % Selects the median value among the first, middle, and last elements.
    %
    % Prevents worst-case quadratic behavior on sorted/nearly-sorted data by picking a balanced pivot.

    mid = low + floor((high - low) / 2);

    % Compares and sorts low and mid elements
    comps = comps + 1;
    if A(mid) < A(low)
        temp = A(low); A(low) = A(mid); A(mid) = temp;
    end

    % Compares and sorts low and high elements
    comps = comps + 1; 
    if A(high) < A(low)
        temp = A(low); A(low) = A(high); A(high) = temp;
    end

    % Compares and sorts mid and high elements to isolate median index
    comps = comps + 1; 
    if A(mid) < A(high)
        pivotIndex = mid;
    else
        pivotIndex = high;
    end
end