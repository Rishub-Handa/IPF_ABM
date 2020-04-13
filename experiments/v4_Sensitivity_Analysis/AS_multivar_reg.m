data = readtable('data/Global-Sampling-table.csv', 'HeaderLines', 6); 
data(1:5, :)

run_idx = find(string(data.Properties.VariableNames) == "x_runNumber_"); 
deg_idx = find(string(data.Properties.VariableNames) == "degrader_count");
t1p_idx = find(string(data.Properties.VariableNames) == "thy1ps_count");
t1n_idx = find(string(data.Properties.VariableNames) == "thy1ns_count");
AS_thresh_idx = find(string(data.Properties.VariableNames) == "AS_entry_threshold");
AS_rand_idx = find(string(data.Properties.VariableNames) == "AS_entry_random");
AS_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_tissue_type__alveolar_space_AndPcolor__White__"); 
med_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_128__CountPatches"); 
stiff_idx = find(string(data.Properties.VariableNames) == "countPatchesWith_pcolor_125__CountPatches"); 

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
data_agg = splitapply(@mean,data_mat_total(:,1:end),iA); 

X = data_agg(:,[ deg_idx, t1p_idx, t1n_idx, AS_thresh_idx, AS_rand_idx ]); 
Y = data_agg(:, AS_idx); 

[beta, Sigma] = mvregress(X,Y)

sample = [ 10 10 10 15 50 ]; 
sample*beta



