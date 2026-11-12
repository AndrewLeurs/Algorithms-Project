% Script to execute and gather metrics/generate plots 
% runExperiments.m 
% Sylvester Reyes 


function runExperiments()

    % RunExperiments Master script to execute all tasks
    % 
    % Acts as the single entry oint to run correctness verification (Task
    % 1.1), Performance and Pivot Comparisons (Task 1.3), and knapsack
    % optimization (Part 2).

    % clears the command window output cleanly without perfomance warnings 
    clc;

    disp('==================================================');
    disp('  CS 3364 Algorithms Project - Experiment Runner ');
    disp('==================================================');


    % ---- Task 1.1: Correctness & Edge Case Verification ----
    % --- Sylvester Reyes 

    runTask1_1();

    fprintf('\n-------------------------------------------------------------------\n\n');

    % ---- Task 1.3: Performance and Pivot Comparisons ----
    % --- Sylvester Reyes
    runTask1_3();

    fprintf('\n-------------------------------------------------------------------\n\n');

    % ---- Part 2: Knapsack DP &  Optimal Enumeration ----
    % --- Sylvester Reyes
    disp('===       Executing Planet Zorb Knapsack Analysis      ===');
    try 
        knapsackDP();
    catch ME
        fprintf('Error executing knapsack analysis: %s\n', ME.message);
    end

    disp('============================================================');
    disp('              Experiment execution complete.');
    disp('============================================================');
end

function runTask1_1()
    % runTask1_1 validates QuickYbridSort across all mandatory edge cases
    % and test distributions.
    % 
    % Sylvester Reyes  
    %
    % Iterates through empty arrays, single elements, duplicates, all-equal
    % arrays, sorted arrays, reverse-sorted arrays, and negative mixed
    % arrays across K in {0, 8, 32}

    disp('=== Starting Task 1.1 Correctness & Edge Case Tests ===');

    % Defines test categoris and their input arrays
    testCases = {
        'Empty Array', [];
        'Single Element', [42];
        'Duplicates', [5, 2, 9, 5, 2, 3, 9, 1];
        'All Equal', [7, 7, 7, 7, 7];
        'Already Sorted', [1, 2, 3, 4, 5, 6, 7, 8];
        'Reverse Sorted', [8, 7, 6, 5, 4, 3, 2, 1];
        'Mixed Negatives', [-3, 12, -7, 0, 5, -3, 8, -12]
        };

    K_values = [0, 8, 32];
    pivot_rules = {'median3', 'random'};
    allPassed = true;

    % Outer loop: iterates over each distinct test category
    for t = 1:size(testCases, 1)
        testName = testCases{t, 1};
        inputArr = testCases{t, 2};

        % Middle loop: iterates over threshold values K
        for kIndex = 1:length(K_values)
            K = K_values(kIndex);

            % Inner Loop: iterates over pivot selection strategies
            for pivotIndex = 1:length(pivot_rules)
                rule = pivot_rules{pivotIndex};

                try
                    % Executes custom hybrid sorting 
                    [sortedArr, ~, ~] = QuickHybridSort(inputArr, K, rule);
                    
                    % Generates MATLAB built-in sort for BaseLine exact
                    % verification
                    expectedArr = sort(inputArr);

                    % Verifies sorting order and value
                    isSorted = issorted(sortedArr);
                    isEqualVals = isequal(sort(sortedArr), sort(expectedArr));

                    if ~(isSorted && isEqualVals)
                        fprintf('[FAIL] Test: %s | K = %d | Rule = %s \n', testName, K, rule);
                        allPassed = false;
                    end
                catch ME
                    fprintf('[ERROR] Test: %s | K = %d | Rule = %s | MSG: %s \n', testName, K, rule, ME.message);
                    allPassed = false;
                end
            end
        end
    end

    if allPassed
        disp('[PASS] All tests 1.1 test categoris passed successfully');
        
        disp('=== Empty Array Metrics ===');
        EmptyArr = [];
        disp('Original Array Test Cases Empty:'); disp(EmptyArr);
        [testCases, comps, writes] = QuickHybridSort(EmptyArr, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(EmptyArr, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(EmptyArr, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        disp('====================================================');

        disp('=== Single Element Array Metrics ===');
        SingleArr = [42];
        disp('Original Array Test Cases Single: '); disp(SingleArr);
        [testCases, comps, writes] = QuickHybridSort(SingleArr, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(SingleArr, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(SingleArr, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        disp('====================================================');

        disp('=== Duplicate Array Metrics ===');
        Duplicates = [5, 2, 9, 5, 2, 3, 9, 1];
        disp('Original Array Test Cases Duplicates:'); disp(Duplicates);
        [testCases, comps, writes] = QuickHybridSort(Duplicates, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d \n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(Duplicates, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d \n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(Duplicates, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d \n', comps, writes);
        disp('====================================================');

        disp('=== All Equal Array Metrics ===');
        AllEqual = [7, 7, 7, 7, 7];
        disp('Original Array Test Cases All Equal: '); disp(AllEqual);
        [testCases, comps, writes] = QuickHybridSort(AllEqual, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(AllEqual, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(AllEqual, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        disp('====================================================');

        disp('=== Already Sorted Array Metrics ===');
        AlreadySorted = [1, 2, 3, 4, 5, 6, 7, 8];
        disp('Original Array Test Cases Already Sorted: '); disp(AlreadySorted);
        [testCases, comps, writes] = QuickHybridSort(AlreadySorted, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(AlreadySorted, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(AlreadySorted, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        disp('====================================================');

        disp('=== Reversed Sorted Array Metrics ===');
        ReverseSorted = [8, 7, 6, 5, 4, 3, 2, 1];
        disp('Original Array Test Cases Reversed Sorted: '); disp(ReverseSorted);
        [testCases, comps, writes] = QuickHybridSort(ReverseSorted, 0, 'median3');
        disp('Array Output K = 0: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(ReverseSorted, 8, 'median3');
        disp('Array Output K = 8: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        [testCases, comps, writes] = QuickHybridSort(ReverseSorted, 32, 'median3');
        disp('Array Output K = 32: '); disp(testCases);
        fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
        disp('====================================================');

        
    else
        disp('[FAIL] Some test categories failed. Inspec sorting logic.');
    end

    % Print Concrete example for input and output deliverables
    disp('--- Example Input and Output Demonstaration ---');
    sampleInput = [-3, 14, -7, 0, 5, -3, 8, -12];
    [sampleOutput, comps, writes] = QuickHybridSort(sampleInput, 0, 'median3');
    disp('Sample Input:'); disp(sampleInput);
    disp('Sample Output (QuickHybridSort, K = 0, median3):'); disp(sampleOutput);
    fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
    [sampleOutput, comps, writes] = QuickHybridSort(sampleInput, 8, 'median3');
    disp('Sample Output (QuickHybridSort, K = 8, median3):'); disp(sampleOutput);
    fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
    [sampleOutput, comps, writes] = QuickHybridSort(sampleInput, 32, 'median3');
    disp('Sample Output (QuickHybridSort, K = 32, median3):'); disp(sampleOutput);
    fprintf('Metrics --> Comparisons: %d | Writes: %d\n', comps, writes);
    disp('====================================================');

end


function runTask1_3()
    % runTask1_3 Executes comparison performance for task 1.3
    %
    % Benchmarks pure Quicksort, QuickHybridSort, pure Insertion Sort, and
    % MATLAB built in sort across sizes {1000, 3000, 6000, 12000}, plus a
    % dedicated pivot rule experiment. 

    disp('=== Starting Task 1.3 Algorithm & Pivot Comparisons ===');
    disp('Sylvester Reyes');

    sizes = [1000, 3000, 6000, 12000];
    numTrials = 3; 
    masterSeed = 3364;
    % sets reproducible master random seed
    rng(masterSeed); 

    optimal_K_map = containers.Map({1000, 3000, 6000, 12000}, {16, 16, 16, 16});
    resultsSummary = struct();

    % Outer Loop: iterates over each iput array size of n
    for s = 1:length(sizes)
        n = sizes(s);
        K_star = optimal_K_map(n);

        timeQuick = zeros(numTrials, 1);
        timeHybrid = zeros(numTrials, 1);
        timeInsertion = zeros(numTrials, 1);
        timeBuiltin = zeros(numTrials, 1);

        % Middle Loop: executes independent trials using identical trial
        % arrays
        for trial = 1:numTrials
            rawArray = randi([0, 100000], 1, n);

            % 1. Pure Quicksort benchmark (K = 0, median3)
            A1 = rawArray;
            tStart = tic;
            QuickHybridSort(A1, 0, 'median3');
            timeQuick(trial) = toc(tStart) * 1000;

            % 2. QuickHybridSort benchmark (K = K*, median3)
            A2 = rawArray;
            tStart = tic;
            QuickHybridSort(A2, K_star, 'median3');
            timeHybrid(trial) = toc(tStart) * 1000;

            % 3. Pure Insertion Sort Benchmark
            A3 = rawArray; 
            tStart = tic;
            insertionSort(A3, 1, length(A3), 0, 0);
            timeInsertion(trial) = toc(tStart) * 1000;

            % 4. MATLAB Built-in Sort timing baseling
            A4 = rawArray;
            tStart = tic;
            sort(A4);
            timeBuiltin(trial) = toc(tStart) * 1000;

        end

        % Output Results 
        resultsSummary(s).n = n;
        resultsSummary(s).meanQuick = mean(timeQuick);
        resultsSummary(s).meanHybrid = mean(timeHybrid);
        resultsSummary(s).meanInsertion = mean(timeInsertion);
        resultsSummary(s).meanBuiltin = mean(timeBuiltin);
    end

    % Displays Formatted results in a table 
    disp('--- Main ALgorithm Comparison Results (Mean Time in ms) ---');
    fprintf('%-8s | %-12s | %-12s | %-15s | %-12s\n', 'n', 'Pure QS', 'Hybrid QS', 'Pure Insertion', 'Built-in');
    fprintf('-------------------------------------------------------------------\n');

    for s = 1:length(sizes)
        fprintf('%-8d | %-12.4f | %-12.4f | %-15.4f | %-12.4f\n', ...
            resultsSummary(s).n, ...
            resultsSummary(s).meanQuick, ...
            resultsSummary(s).meanHybrid, ...
            resultsSummary(s).meanInsertion, ...
            resultsSummary(s).meanBuiltin ...
            );
    end
    fprintf('-------------------------------------------------------------------\n\n');

    % --- Comparison Plot of Average Sorting time vs. n ----
    fig = figure('Name', 'Task 1.3: Algorithm Sorting Time Comparison', 'Color', 'white');
    n_vals = [resultsSummary.n];

    plot(n_vals, [resultsSummary.meanQuick], '-o', 'LineWidth', 1.5, 'DisplayName', 'Pure Quicksort (K = 0, median3)');
    hold on;
    plot(n_vals, [resultsSummary.meanHybrid], '-s', 'LineWidth', 1.5, 'DisplayName', 'QuickHybridSort (K*, median3');
    plot(n_vals, [resultsSummary.meanInsertion], '-^', 'LineWidth', 1.5, 'DisplayName', 'Pure Insertion Sort');
    plot(n_vals, [resultsSummary.meanBuiltin], '--d', 'LineWidth', 2.0, 'Color', 'black', 'DisplayName', 'MATLAB Built-in sort()');
    hold off;

    grid on;
    xlabel('Input Array Size n (elements)', 'FontSize', 11, 'FontWeight', 'bold');
    ylabel('Average Sorting Time (ms)', 'FontSize', 11, 'FontWeight', 'bold');
    title('Task 1.3: Average Sorting Time vs. Input Size n', 'FontSize', 12);
    legend('Location', 'northwest', 'FontSize', 10);

    % Saves image for report
    exportgraphics(fig, 'Task1_3_ComparisonPlot.png', 'Resolution', 300);

    % Smaller Pivot experiment at n = 6000
    disp('-------- Pivot Experiment (n = 6000) --------');
    n_pivot = 6000;
    pivotConfigs = {'medin3', 0; 'median3', 8; 'median3', 16'; 'median3', 32; 'random', 0; 'random', 8; 'random', 16; 'random', 32};

    fprintf('%-10s | %-6s | %-12s | %-12s | %-12s\n', 'Rule', 'K', 'Mean Time(ms)', 'Comparisons', 'Writes');
    fprintf('-------------------------------------------------------------------\n');

    % Outer loop for pivot configurations
    for p = 1:size(pivotConfigs, 1)
        rule = pivotConfigs{p, 1};
        K_val = pivotConfigs{p, 2};

        t_acc = 0; comp_acc = 0; write_acc = 0;

        % Inner loop for trial averaging 
        for trial = 1:numTrials
            testArr = randi([0, 100000], 1, n_pivot);
            tStart = tic;
            [~, comps, writes] = QuickHybridSort(testArr, K_val, rule);
            t_acc = t_acc + (toc(tStart) * 1000);
            comp_acc = comp_acc + comps;
            write_acc = write_acc + writes;
        end
        fprintf('%-10s | %-6d | %-12.4f | %-12.2f | %-12.2f\n', ...
            rule, K_val, t_acc/numTrials, comp_acc/numTrials, write_acc/numTrials);
    end
end

