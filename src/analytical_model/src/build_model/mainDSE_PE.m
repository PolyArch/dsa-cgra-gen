clear

%% Import Data
DedicatedPEDSE = importDSE_PE("/home/sihao/ss-cgra-gen/src/analytical_model/resource/Dedicated_PE_DSE_20190408_175343.csv");

%% Clean Data
PE_DSE = cleanDSE_PE(DedicatedPEDSE);

%% Start Trainning
% Pick Data and set Parameter for Neural Net
inputs = table2array(PE_DSE(:,1:end-2))';
targets_area = PE_DSE.mappedareaTotalcellarea';
targets_power = PE_DSE.mappedpowerTotal';
% Train Area Net
[net_area,tr_area] = trainDSE_PE(inputs,targets_area);
% Train Power Net
[net_power,tr_power] = trainDSE_PE(inputs,targets_power);
