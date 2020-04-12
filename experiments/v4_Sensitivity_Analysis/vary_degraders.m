data = readtable('data/Vary-Degraders-table.csv', 'HeaderLines', 6) 

deg_idx = find(string(data.Properties.VariableNames) == "degrader_count")
AS_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_tissue_type__alveolar_space_AndPcolor__White__")
med_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_128__CountPatches")
stiff_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_125__CountPatches")


data_mat = zeros(size(data)); 

for i=1:size(data,1)
    for j=1:size(data,2)
        data_mat(i,j) = str2double(cell2mat(data{i,j})); 
    end
end
 
[C, idx, ic] = unique(data_mat(:,deg_idx)); 
data_agg = splitapply(@mean,data_mat(:,1:end),ic) 

hold on 
plot(data_agg(:, deg_idx), data_agg(:, AS_idx), '-bo', 'LineWidth', 2); 
plot(data_agg(:, deg_idx), data_agg(:, med_idx), '-o', 'LineWidth', 2); 
plot(data_agg(:, deg_idx), data_agg(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Degraders Count"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. Degrader Count"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 






