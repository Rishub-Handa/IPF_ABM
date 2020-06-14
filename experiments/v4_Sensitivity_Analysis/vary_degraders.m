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
 
[C, icx, ic] = unique(data_mat(:,deg_idx)); 
data_agg = splitapply(@mean,data_mat(:,1:end),ic) 
 
[D, idx, id] = unique(data_mat(:,deg_idx)); 
data_agg_std = splitapply(@mean,data_mat(:,1:end),id) 

n = size(icx, 1) 

data_agg_conf = (1.96 .* data_agg_std) ./ sqrt(n); 

figure(1) 
hold on 
errorbar(data_agg(:, deg_idx), data_agg(:, AS_idx), data_agg_std(:, AS_idx), '-bo', 'LineWidth', 2); 
errorbar(data_agg(:, deg_idx), data_agg(:, med_idx), data_agg_std(:, med_idx), '-o', 'LineWidth', 2); 
errorbar(data_agg(:, deg_idx), data_agg(:, stiff_idx), data_agg_std(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Degraders Count"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. Degrader Count w Error Bars"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 

figure(2) 
hold on 
errorbar(data_agg(:, deg_idx), data_agg(:, AS_idx), data_agg_conf(:, AS_idx), '-bo', 'LineWidth', 2); 
errorbar(data_agg(:, deg_idx), data_agg(:, med_idx), data_agg_conf(:, med_idx), '-o', 'LineWidth', 2); 
errorbar(data_agg(:, deg_idx), data_agg(:, stiff_idx), data_agg_conf(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Degraders Count"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. Degrader Count w Conf Interval"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 





