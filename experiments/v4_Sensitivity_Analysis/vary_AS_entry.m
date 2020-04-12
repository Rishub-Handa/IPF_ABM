data = readtable('data/AS-Entry-Bivariate-table.csv', 'HeaderLines', 6) 

AS_thresh_idx = find(string(data.Properties.VariableNames) == "AS_entry_threshold"); 
AS_rand_idx = find(string(data.Properties.VariableNames) == "AS_entry_random"); 
AS_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_tissue_type__alveolar_space_AndPcolor__White__"); 
med_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_128__CountPatches"); 
stiff_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_125__CountPatches"); 
run_idx = find(string(data.Properties.VariableNames) == "x_runNumber_"); 


data_mat = zeros(size(data)); 

for i=1:size(data,1)
    for j=1:size(data,2)
        data_mat(i,j) = str2double(cell2mat(data{i,j})); 
    end
end
 
data_mat_total = data_mat; 

data_mat(:, run_idx) = []; 
data_mat(:, 10:end) = []; 

[B, iB, iA] = unique(data_mat, 'rows');
data_agg_biv = splitapply(@mean,data_mat_total(:,1:end),iA) 

[C, idx, ic] = unique(data_mat_total(:,AS_thresh_idx)); 
data_agg_thresh = splitapply(@mean,data_mat_total(:,1:end),ic) 

[D, idx, id] = unique(data_mat_total(:,AS_rand_idx)); 
data_agg_rand = splitapply(@mean,data_mat_total(:,1:end),id) 

% 2D Plot 

% AS-entry-threshold 
figure(1)
hold on 
plot(data_agg_thresh(:, AS_thresh_idx), data_agg_thresh(:, AS_idx), '-bo', 'LineWidth', 2); 
plot(data_agg_thresh(:, AS_thresh_idx), data_agg_thresh(:, med_idx), '-o', 'LineWidth', 2); 
plot(data_agg_thresh(:, AS_thresh_idx), data_agg_thresh(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Alveolar Space Threshold"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. AS-entry-threshold"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 

% AS-entry-random 
figure(2)
hold on 
plot(data_agg_rand(:, AS_rand_idx), data_agg_rand(:, AS_idx), '-bo', 'LineWidth', 2); 
plot(data_agg_rand(:, AS_rand_idx), data_agg_rand(:, med_idx), '-o', 'LineWidth', 2); 
plot(data_agg_rand(:, AS_rand_idx), data_agg_rand(:, stiff_idx), '-ro', 'LineWidth', 2); 
xlabel("Alveolar Space Random"); 
ylabel("% Patches"); 
title("% Patches with Collagen vs. AS-entry-random"); 
legend("% Alveolar Space w Collagen", "% Medium Patches", "% Stiff Patches"); 
hold off 

% 3D Plot Bivariate 


% Try surf 

figure(3) 

% plot3(data_agg_biv(:, AS_thresh_idx), data_agg_biv(:, AS_rand_idx), data_agg_biv(:, AS_idx), '-bo', 'LineWidth', 2); 
subplot(2,2,1); 
hold on 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, AS_idx), [11, 11])); 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, med_idx), [11, 11])); 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, stiff_idx), [11, 11])); 
xlabel("Alveolar Space Threshold"); 
ylabel("Alveolar Space Random"); 
zlabel("% Patches"); 
title("Top - % AS, Middle - % Stiff, Bottom - % Medium"); 
hold off 

subplot(2,2,2); 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, AS_idx), [11, 11])); 
xlabel("Alveolar Space Threshold"); 
ylabel("Alveolar Space Random"); 
zlabel("% Alveolar Space w Collagen"); 
title("% Alveolar Patches with Collagen vs. AS-entry-threshold vs. AS-entry-random"); 

subplot(2,2,3); 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, med_idx), [11, 11])); 
xlabel("Alveolar Space Threshold"); 
ylabel("Alveolar Space Random"); 
zlabel("% Medium Patches"); 
title("% Medium Patches vs. AS-entry-threshold vs. AS-entry-random"); 

subplot(2,2,4); 
surf(data_agg_thresh(:, AS_thresh_idx), data_agg_rand(:, AS_rand_idx), reshape(data_agg_biv(:, stiff_idx), [11, 11])); 
xlabel("Alveolar Space Threshold"); 
ylabel("Alveolar Space Random"); 
zlabel("% Stiff Patches"); 
title("% Stiff Patches vs. AS-entry-threshold vs. AS-entry-random"); 



