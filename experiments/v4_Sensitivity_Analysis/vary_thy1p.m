data = readtable('data/Vary-Thy1p-table.csv', 'HeaderLines', 6) 

t1p_idx = find(string(data.Properties.VariableNames) == "thy1ps_count")
AS_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_tissue_type__alveolar_space_AndPcolor__White__")
med_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_128__CountPatches")
stiff_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_125__CountPatches")


data_mat = zeros(size(data)); 

for i=1:size(data,1)
    for j=1:size(data,2)
        data_mat(i,j) = str2double(cell2mat(data{i,j})); 
    end
end
 
[C, idx, ic] = unique(data_mat(:,t1p_idx)); 
data_agg = splitapply(@mean,data_mat(:,1:end),ic) 

hold on 
plot(data_agg(:, t1p_idx), data_agg(:, AS_idx), '-bo', 'LineWidth', 2); 
plot(data_agg(:, t1p_idx), data_agg(:, med_idx), '-o', 'LineWidth', 2); 
plot(data_agg(:, t1p_idx), data_agg(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Thy1p Count"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. Thy1p Count"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 






