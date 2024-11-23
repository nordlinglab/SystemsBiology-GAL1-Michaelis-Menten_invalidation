close all
clear

fprintf('\n\n --->Robust Identifiability analysis. This may take a while...')

rng('default')

pause(1)

Td = 0; % system delay

load('ZAD4_Mean_Norm2CI_smoothed.mat');
load('GuessSet50.mat')
num_set = length(GuessSet);

setNames = {'nd032','nd039','nd053','nd057'};
ModelName = '3ODEs';

if length(setNames) == 1
    set_num = 'single';
elseif length(setNames) == 2
    set_num = 'paired';
elseif length(setNames) == 3
    set_num = 'triple';
elseif length(setNames) == 4
    set_num = 'all4';
end

if length(setNames) == 1
    setNames1 = setNames;
elseif length(setNames) == 2
    setNames1 = setNames;
elseif length(setNames) == 3
    setNames1 = setNames;
elseif length(setNames) == 4
    setNames1 = 'All4';
end

%% k for call CI data as errorbars
jump = 6;
k_set = [];

for id = 1:length(setNames)
    if strcmp(setNames{id}, 'nd032')
        k = 1;
    elseif strcmp(setNames{id}, 'nd039')
        k = 2;
    elseif strcmp(setNames{id}, 'nd053')
        k = 3;
    elseif strcmp(setNames{id}, 'nd057')
        k = 4;
    end
    k_set = [k_set, k];
end

%% Loop for 1000 times with random guess sets
tic

gal1_3ODEs
num_exp = inputs.exps.n_exp;

% Important: do *not* create a parallel pool prior to running this!
delete(gcp('nocreate')); %make sure parallel pool is not ceated

% Check if a parallel pool already exists, and if not, create one
poolobj = gcp('nocreate');
if isempty(poolobj)
    parpool();  % Create a parallel pool
end
addAttachedFiles(gcp, '/home/raychen/Desktop/MATLAB/AMIGO2_R2019b/ToServerVersion/');

%%
parfor i = 1:num_set
    inputs_copy = inputs;
    if GuessSet{1,i}(14) > GuessSet{1,i}(2) || GuessSet{1,i}(13) > GuessSet{1,i}(1)
        continue
    end
    
    AllY_simuli_tempRec = cell(1, num_exp);
    Ally_m_tempRec = cell(1, num_exp);
    setExceedRate_tempRec = cell(1, num_exp);
    AllResidual_tempRec = cell(1, num_exp);
    setRecord_tempRec = cell(1, num_exp);
    Allpar_guess_tempRec = cell(1, num_exp);
    Allpar_results_tempRec = cell(1, num_exp);
    Allpar_dist_tempRec = cell(1, num_exp);
    AllFIT_tempRec = cell(1, num_exp);
    
    %specify where to save the results
    ith = num2str(i);
    str_folder = string(["Gal1_PE_ScenarioA", ModelName, set_num, setNames1, ith,]);
    NameString_folder = char(join(str_folder, '_'));
    str_short = string(["gal1ident",ModelName, set_num, setNames1, ith,]);
    NameString_short = char(join(str_short,'_'));
    inputs_copy.pathd.results_folder = NameString_folder;
    inputs_copy.pathd.short_name = NameString_short;
    
    % for parameter estimation
    theta_y0_max1 = GuessSet{1,i}(1);
    theta_y0_max2 = GuessSet{1,i}(2);
    
    inputs_copy.PEsol.id_global_theta_y0 = char('GAL1_mRNA','Gal1_prot');
    inputs_copy.PEsol.id_global_theta='all';
    inputs_copy.PEsol.global_theta_y0_min = [0, 0];
    inputs_copy.PEsol.global_theta_y0_max = [theta_y0_max1, theta_y0_max2];
    
    inputs_copy.PEsol.global_theta_max =  [9.5e+0, 5.5e+2, 1.0e+1, 1.0e+2, 3.0e-0, 7.0e-0, 1.5e-0, 4.0e+0, 4.0e+0];
    inputs_copy.PEsol.global_theta_min =  [5.5e-12,1.5e-3, 1.0e-9, 1.0e-8, 2.0e-7, 7.0e-7, 1.5e-5, 4.0e-8, 4.0e-9];
    inputs_copy.PEsol.global_theta_guess = GuessSet{1,i}(3:11);
    
    Y1eq = GuessSet{1,i}(12);
    Y2eq = GuessSet{1,i}(13);
    Y3eq = GuessSet{1,i}(14);
    inputs_copy.PEsol.global_theta_y0_guess = [Y2eq, Y3eq];
    
    AMIGO_Prep(inputs_copy)  % Call the task for pre-processing
    AMIGO_PE(inputs_copy)    % parameter estimation
    
    % get FIT results
    ResultFolder = inputs_copy.pathd.results_folder;
    ResultFile = inputs_copy.pathd.short_name;
    Solver = inputs_copy.nlpsol.nlpsolver;
    Runindent = inputs_copy.pathd.runident;
    Results = load(['/home/raychen/Desktop/MATLAB/AMIGO2_R2019b/Results/',ResultFolder,'/PE_',ResultFile,'_',Solver,'_',Runindent,'/strreport_',ResultFile,'_',Runindent,'.mat']);
    
    for j = 1:num_exp
        y_m = (inputs_copy.exps.exp_data{1,j})';
        Y_simuli = (Results.results.sim.sim_data{1,j})';
        SetName = setNames{1,j};
        IN = inputs_copy.exps.u{j}(1,:);
        CI_Len = length(IN);
        for k = k_set(j)
            CI_UpLim_025 = ZAD4_Mean2CI.(subsref(fieldnames(ZAD4_Mean2CI),substruct('{}',{jump*(k-1)+3})));
            CI_UpLim_025 = CI_UpLim_025(1:CI_Len);
            CI_LowLim_025 = ZAD4_Mean2CI.(subsref(fieldnames(ZAD4_Mean2CI),substruct('{}',{jump*(k-1)+4})));
            CI_LowLim_025 = CI_LowLim_025(1:CI_Len);
            CI_UpLim_125 = ZAD4_Mean2CI.(subsref(fieldnames(ZAD4_Mean2CI),substruct('{}',{jump*(k-1)+5})));
            CI_UpLim_125 = CI_UpLim_125(1:CI_Len);
            CI_LowLim_125 = ZAD4_Mean2CI.(subsref(fieldnames(ZAD4_Mean2CI),substruct('{}',{jump*(k-1)+6})));
            CI_LowLim_125 = CI_LowLim_125(1:CI_Len);
            time = 0:5:(CI_Len-1)*5;
            
            [h,p,ks2stat] = kstest2(y_m,Y_simuli);
            
            [R_2,aR_2,FPE,AIC,FIT] = Residual(Y_simuli,y_m,9);
        end
        AllY_simuli_tempRec{j} = Y_simuli;
        Ally_m_tempRec{j} = y_m;
        
        UpBound975 = y_m + CI_UpLim_025;
        LowBound975 = y_m - CI_LowLim_025;
        UpBound75 = y_m + CI_UpLim_125;
        LowBound75 = y_m - CI_LowLim_125;
        
        Exceed95 = length(find((Y_simuli > UpBound975) | (Y_simuli < LowBound975)));
        Exceed75 = length(find((Y_simuli > UpBound75) | (Y_simuli < LowBound75)));
        ExceedRate95 = 100*Exceed95/CI_Len;
        ExceedRate75 = 100*Exceed75/CI_Len;
        
        setExceedRate_tempRec{j} = [ExceedRate95, ExceedRate75];
        
        [R_24,aR_24,FPE4,AIC4,FIT4] = Residual(Y_simuli,y_m,9);
        residual = Y_simuli - y_m;
        AllResidual_tempRec{j} = residual;
        [Figure, Record] = PlotnSave(ResultFolder,i,set_num, SetName, ModelName, y_m, Y_simuli, IN, CI_UpLim_025, CI_LowLim_025, CI_UpLim_125, CI_LowLim_125,residual, time, R_2, aR_2, FPE, AIC, FIT, h, p, ks2stat);
        setRecord_tempRec{j} = Record;
        parGuess = GuessSet{1,i}(3:11);
        Allpar_guess_tempRec{j} = [parGuess,Y2eq, Y3eq]';
        Allpar_results_tempRec{j} = Results.results.nlpsol.vbest;
        Allpar_dist_tempRec{j} = Allpar_results_tempRec{j} - Allpar_guess_tempRec{j};
        AllFIT_tempRec{j} = setRecord_tempRec{j}.valid_FIT;
        
    end

    %Allpar_guess = Allpar_guess_tempRec; %for matching the record dimension
    Record1000ic = struct('y_m',Ally_m_tempRec, 'y_simuli',AllY_simuli_tempRec, 'residual',AllResidual_tempRec,...
        'Record',setRecord_tempRec,'FIT',AllFIT_tempRec, 'ExceedRate',setExceedRate_tempRec,...
        'par_guess',Allpar_guess_tempRec, 'par_results',Allpar_results_tempRec, 'par_dist',Allpar_dist_tempRec);
    File = ['/home/raychen/Desktop/MATLAB/AMIGO2_R2019b/Results/',ResultFolder,'/Record1000ic_',ith,'.mat'];
    parsave(File, Record1000ic)
    disp('Record Saved')  
end
toc

%% parsave
function parsave(filename, variables)
  save(filename, 'variables')
end
