valori = [1 1 3 2 3 2 4 4 5 4 1 1 1 4 3 4 2 4 5 4 4 4 3 5 5 3 3];

[counts, bin_centers] = hist(valori);

cumulative_counts = cumsum(counts);

figure;
bar(bin_centers, cumulative_counts);

grid on;
