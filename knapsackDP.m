% bottom-up 0/1 knapsack implementation and traceback logic 
% knapsackDP.m 
% Sylvester Reyes 

function [maxScore, optimalSets] = knapsackDP()
    % KnapsackDP solves the Planet Zorb 0/1 problem and enumerates all
    % optimal sets
    %
    % satisfies tasks 2.2, 2.3 and 2.4 fo the project specifications.
    % implemented 2.3 as it was easier to implement all tasks in one due to
    % the nature of the problem 
    % 
    % Populates a bottom-up dynamic programming table and recursively
    % traces back through state ties to discover every distint optimal item
    % combination.
    %
    % OutPuts: 
    %       maxScore - Maximum biodiversity research score achieved
    %       optimalSets - Cell array containing all distinct item ID
    %       combinations

    % Defines prblem parameters for planet Zorb expedition (Capacity W =
    % 17)

    weights = [4, 7, 5, 3, 6, 2];
    scores = [130, 220, 160, 100, 190, 70];
    W = 17;
    n = length(weights);

    % Initializes DP table with zeros: (n + 1) rows by (W + 1) columns
    % Rows represent items considered (0 to n), Columns represent weight
    % capacity (0 to W)
    DP = zeros(n + 1, W + 1);

    % Tasks 2.2 & 2.3: Bottom-Up table
    % Outer loop: iterates over each item (i) from (1) to (n)
    for i = 1:n
        % Inner Loop: iterates over each possible weight capacit (w) from
        % (0) to (W)
        for w = 0:W
            currWeight = weights(i);
            currScore = scores(i);

            % Checks if the current item's weight fits within capacity (w)
            if currWeight <= w
                % itme fits: compute maximum value between skipping or
                % taking the item 
                skipVal = DP(i, w + 1);                             % Value if item (i) is skipped
                takeVal = currScore + DP(i, w - currWeight + 1);    % Value if itme (i) is taken 
                DP(i + 1, w + 1) = max(skipVal, takeVal);           % Store optimal choice
            else
                % Item does not fit, inherit value from skipping item (i)
                DP(i + 1, w + 1) = DP(i, w + 1);
            end
        end
    end

    % maximum biodiversity score from the bottom-right corner of the DP
    % table 
    maxScore = DP(n + 1, W + 1);
    fprintf('\nMaximum biodiversity Score Achieved: %d\n\n', maxScore);

    % Task 2.3 (one optimal list of item IDs, the total selected weight,
    % and the total selected score)
    % Andrew Leurs

    fprintf('Optimal List of Item IDs: ');

    OptimalList = []; % Stores items in array
    curr_i = n + 1;
    curr_w = W + 1;
    totalWeight = 0;
    totalScore = 0;
    while true
        % Compare current cell value to cell above
        % If current value == above value, above cell = current cell, cont
        if DP(curr_i, curr_w) == DP(curr_i - 1, curr_w)
            curr_i = curr_i - 1;
        % Else add i to OptimalList, subtract weight_i from w, decrement i
        else
            OptimalList = [OptimalList, curr_i - 1];
            totalWeight = totalWeight + weights(curr_i - 1);
            totalScore = totalScore + scores(curr_i - 1);

            % Update remaining capacity & item #
            curr_w = curr_w - weights(curr_i - 1);
            curr_i = curr_i - 1;
        end

        % If curr_i = 1 or curr_w = 1,
        if curr_i == 1 || curr_w == 1
            break;
        end
        % break
    end
    % Print the Optimal list
    for k = 1:numel(OptimalList)
        fprintf("%d ", OptimalList(k));
    end
    
    % Print total score and total weight
    fprintf("\nTotal Weight: %d\n", totalWeight);
    fprintf("Total Score After Backtracking: %d\n\n", totalScore);

    % End of Andrew's code

    % Task 2.4 Enumerates every Distinct Optimal Selection 
    optimalSets = {};

    % Nested recursive helper function to trace back through table states
    % and handle ties 

function backtrack(i, currentW, currentScore, currentItems)
% Base Case: reached the top of the DP table (0 items remaining)
    if i == 0
        % if accumulated score matches the global maximum score, record the
        % item set 
        if currentScore == maxScore
            optimalSets{end + 1} = sort(currentItems);
        end
        return;
    end

    currWeight = weights(i);
    currScoreVal = scores(i);
    cellVal = DP(i + 1, currentW + 1);

    if cellVal == DP(i, currentW + 1)
        backtrack(i - 1, currentW, currentScore, currentItems);
    end
    % Checks option B (take) when the item fits and preserves optimality
    if currWeight <= currentW && cellVal == currScoreVal + DP(i, currentW - currWeight + 1)
        backtrack(i - 1, currentW - currWeight, currentScore + currScoreVal, ...
            [currentItems, i]);
    end
end

% initiates recursive backtracking from the bottom-right corner of the DP
% table 

backtrack(n, W, 0, []);

% filters out redundant duplicate set representations 
if ~isempty(optimalSets)

    % converts cell array of vectors to strings for filtering
    strCells = cellfun(@(c) sprintf('%d', c), optimalSets, 'UniformOutput', false);
    [~, uniqueIdx] = unique(strCells);
    optimalSets = optimalSets(uniqueIdx);
    
    disp('-----       Distinct Optimal Item Sets Found      -----');

    % loops through and prints each distinct optimal selection, total
    % weights, and score 
    for idx = 1:length(optimalSets)
        itemIndices = optimalSets{idx}; % standard num
        setW = sum(weights(itemIndices));
        fprintf('Solution %d --> Item IDs: [%s] | Total Weight: %d | Total Score: %d\n', ...
            idx, num2str(itemIndices), setW, maxScore);
    end
else
    disp('No optimal sets found.');
end
end
