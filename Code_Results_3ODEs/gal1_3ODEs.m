%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.runident = 'r1';
% Identifier required in order not to overwrite previous results This may be modified from command line. 'run1'(default)

%============================
% MODEL RELATED DATA
%============================
inputs.model.input_model_type = 'charmodelC'; % Model introduction: 
% 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'| 

inputs.model.n_st = 3;        % Number of states                                 
inputs.model.n_par = 9;       % Number of model parameters                                 
inputs.model.n_stimulus = 1;  % Number of inputs, stimuli or control variables   
inputs.model.st_names = char('GAL1_mRNA','Gal1_prot','Gal1_Gfp'); % States name                                  
inputs.model.par_names = char('alpha1','Vm','Km','H','d1','alpha2','d2','Kf','Kb'); % Parameter names                     
inputs.model.stimulus_names = char('Gal'); % Name of input                    
inputs.model.eqns=...  % Equations describing system dynamics.
       char('dGAL1_mRNA = alpha1+Vm*(Gal^H/(Km^H+Gal^H))-d1*GAL1_mRNA',...
            'dGal1_prot = alpha2*GAL1_mRNA-d2*Gal1_prot',...
            'dGal1_Gfp = Kf*Gal1_prot-Kb*Gal1_Gfp');
%==================================
% EXPERIMENTAL SCHEME RELATED DATA
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type = 'real';  % Type of data: 'pseudo'|'pseudo_pos'|'real'             
inputs.exps.noise_type = 'homo'; %'homo'|'homo_var'|'hetero'
inputs.exps.n_exp = 4;           % Number of experiments
%exp_y0_EstFactor = [a,b,c];
a = 1.2;%1.02;
b = 1.1;%1.01;
c = 1.0;

%==========

% nd032
inputs.exps.n_obs{1} = 1;
inputs.exps.obs_names{1} = char('Gal1_Gfp');
inputs.exps.obs{1} = char('Fluorescence=Gal1_Gfp'); 
input_nd032 = ZAD4_Mean2CI.nd032_IN(1:236-Td);
Len_nd032 = length(input_nd032);
inputs.exps.t_f{1} = Len_nd032*5;
inputs.exps.n_s{1} = Len_nd032;
inputs.exps.t_s{1} = [0:5:(Len_nd032-1)*5];
inputs.exps.u_interp{1} = 'linear';
inputs.exps.n_linear{1} = inputs.exps.n_s{1};
inputs.exps.u{1}(1,:) = input_nd032;
inputs.exps.t_con{1} = 0:5:(Len_nd032-1)*5;
inputs.exps.std_dev{1} = [0];
output_nd032 = ZAD4_Mean2CI.nd032_OUT(1:236);
inputs.exps.exp_data{1} = output_nd032(Td+1:Len_nd032+Td)'; %delay the output
ic1 = [inputs.exps.exp_data{1}(1)];
inputs.exps.exp_y0{1} = [ic1*a, ic1*b, ic1*c];

% nd039
inputs.exps.n_obs{2} = 1;
inputs.exps.obs_names{2} = char('Gal1_Gfp');
inputs.exps.obs{2} = char('Fluorescence=Gal1_Gfp'); 
input_nd039 = ZAD4_Mean2CI.nd039_IN(1:335-Td);
Len_nd039 = length(input_nd039);
inputs.exps.t_f{2} = Len_nd039*5;
inputs.exps.n_s{2} = Len_nd039;
inputs.exps.t_s{2} = [0:5:(Len_nd039-1)*5];
inputs.exps.u_interp{2} = 'linear';
inputs.exps.n_linear{2} = inputs.exps.n_s{2};
inputs.exps.u{2}(1,:) = input_nd039;
inputs.exps.t_con{2} = 0:5:(Len_nd039-1)*5;
inputs.exps.std_dev{2} = [0];
output_nd039 = ZAD4_Mean2CI.nd039_OUT(1:335);
inputs.exps.exp_data{2} = output_nd039(Td+1:Len_nd039+Td)'; %delay the output
ic2 = [inputs.exps.exp_data{2}(1)];
inputs.exps.exp_y0{2} = [ic2*a, ic2*b, ic2*c];
 
% nd053
inputs.exps.n_obs{3} = 1;
inputs.exps.obs_names{3} = char('Gal1_Gfp');
inputs.exps.obs{3} = char('Fluorescence=Gal1_Gfp'); 
input_nd053 = ZAD4_Mean2CI.nd053_IN(1:635-Td);
Len_nd053 = length(input_nd053);
inputs.exps.t_f{3} = Len_nd053*5;
inputs.exps.n_s{3} = Len_nd053;
inputs.exps.t_s{3} = [0:5:(Len_nd053-1)*5];
inputs.exps.u_interp{3} = 'linear';
inputs.exps.n_linear{3} = inputs.exps.n_s{3};
inputs.exps.u{3}(1,:) = input_nd053;
inputs.exps.t_con{3} = 0:5:(Len_nd053-1)*5;
inputs.exps.std_dev{3} = [0];
output_nd053 = ZAD4_Mean2CI.nd053_OUT(1:635);
inputs.exps.exp_data{3} = output_nd053(Td+1:Len_nd053+Td)'; %delay the output
ic3 = [inputs.exps.exp_data{3}(1)];
inputs.exps.exp_y0{3} = [ic3*a, ic3*b, ic3*c];

%nd057
inputs.exps.n_obs{4} = 1;
inputs.exps.obs_names{4} = char('Gal1_Gfp');
inputs.exps.obs{4} = char('Fluorescence=Gal1_Gfp'); 
input_nd057 = ZAD4_Mean2CI.nd057_IN(1:455-Td);
Len_nd057 = length(input_nd057);
inputs.exps.t_f{4} = Len_nd057*5;
inputs.exps.n_s{4} = Len_nd057;
inputs.exps.t_s{4} = [0:5:(Len_nd057-1)*5];
inputs.exps.u_interp{4} = 'linear';
inputs.exps.n_linear{4} = inputs.exps.n_s{4};
inputs.exps.u{4}(1,:) = input_nd057;
inputs.exps.t_con{4} = 0:5:(Len_nd057-1)*5;
inputs.exps.std_dev{4} = [0];
output_nd057 = ZAD4_Mean2CI.nd057_OUT(1:455);
inputs.exps.exp_data{4} = output_nd057(Td+1:Len_nd057+Td)'; %delay the output
ic4 = [inputs.exps.exp_data{4}(1)];
inputs.exps.exp_y0{4} = [ic4*a, ic4*b, ic4*c];

% nd039
% inputs.exps.n_obs{1} = 1;
% inputs.exps.obs_names{1} = char('Gal1_Gfp');
% inputs.exps.obs{1} = char('Fluorescence=Gal1_Gfp'); 
% input_nd039 = ZAD4_Mean2CI.nd039_IN(1:335-Td);
% Len_nd039 = length(input_nd039);
% inputs.exps.t_f{1} = Len_nd039*5;
% inputs.exps.n_s{1} = Len_nd039;
% inputs.exps.t_s{1} = [0:5:(Len_nd039-1)*5];
% inputs.exps.u_interp{1} = 'linear';
% inputs.exps.n_linear{1} = inputs.exps.n_s{1};
% inputs.exps.u{1}(1,:) = input_nd039;
% inputs.exps.t_con{1} = 0:5:(Len_nd039-1)*5;
% inputs.exps.std_dev{1} = [0];
% output_nd039 = ZAD4_Mean2CI.nd039_OUT(1:335);
% inputs.exps.exp_data{1} = output_nd039(Td+1:Len_nd039+Td)'; %delay the output
% ic1 = [inputs.exps.exp_data{1}(1)];
% inputs.exps.exp_y0{1} = [ic1*a, ic1*b, ic1*c];
 
% nd053
% inputs.exps.n_obs{1} = 1;
% inputs.exps.obs_names{1} = char('Gal1_Gfp');
% inputs.exps.obs{1} = char('Fluorescence=Gal1_Gfp'); 
% input_nd053 = ZAD4_Mean2CI.nd053_IN(1:635-Td);
% Len_nd053 = length(input_nd053);
% inputs.exps.t_f{1} = Len_nd053*5;
% inputs.exps.n_s{1} = Len_nd053;
% inputs.exps.t_s{1} = [0:5:(Len_nd053-1)*5];
% inputs.exps.u_interp{1} = 'linear';
% inputs.exps.n_linear{1} = inputs.exps.n_s{1};
% inputs.exps.u{1}(1,:) = input_nd053;
% inputs.exps.t_con{1} = 0:5:(Len_nd053-1)*5;
% inputs.exps.std_dev{1} = [0];
% output_nd053 = ZAD4_Mean2CI.nd053_OUT(1:635);
% inputs.exps.exp_data{1} = output_nd053(Td+1:Len_nd053+Td)'; %delay the output
% ic1 = [inputs.exps.exp_data{1}(1)];
% inputs.exps.exp_y0{1} = [ic1*a, ic1*b, ic1*c];

% nd057
% inputs.exps.n_obs{1} = 1;
% inputs.exps.obs_names{1} = char('Gal1_Gfp');
% inputs.exps.obs{1} = char('Fluorescence=Gal1_Gfp'); 
% input_nd057 = ZAD4_Mean2CI.nd057_IN(1:455-Td);
% Len_nd057 = length(input_nd057);
% inputs.exps.t_f{1} = Len_nd057*5;
% inputs.exps.n_s{1} = Len_nd057;
% inputs.exps.t_s{1} = [0:5:(Len_nd057-1)*5];
% inputs.exps.u_interp{1} = 'linear';
% inputs.exps.n_linear{1} = inputs.exps.n_s{1};
% inputs.exps.u{1}(1,:) = input_nd057;
% inputs.exps.t_con{1} = 0:5:(Len_nd057-1)*5;
% inputs.exps.std_dev{1} = [0];
% output_nd057 = ZAD4_Mean2CI.nd057_OUT(1:455);
% inputs.exps.exp_data{1} = output_nd057(Td+1:Len_nd057+Td)'; %delay the output
% ic1 = [inputs.exps.exp_data{1}(1)];
% inputs.exps.exp_y0{1} = [ic1*a, ic1*b, ic1*c];

%==================================
% COST FUNCTION RELATED DATA
%==================================
inputs.PEsol.PEcost_type = 'lsq'; % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost'
%inputs.PEsol.llk_type = 'homo';
%inputs.PEsol.PEcost_type = 'lsq';
inputs.PEsol.lsq_type = 'Q_expmax'; %'Q_I'|'Q_expmax'
%==================================
% NUMERICAL METHODS RELATED DATA
%==================================
% SIMULATION
inputs.ivpsol.ivpsolver = 'cvodes';       % [] IVP solver: 'radau5'(default, fortran)|'rkf45'|'lsodes'|
inputs.ivpsol.senssolver = 'cvodes';      % [] Sensitivities solver: 'cvodes' (C)
inputs.ivpsol.rtol = 1.0e-9;              % [] IVP solver integration tolerances (Relative)
inputs.ivpsol.atol = 1.0e-9;              % [] IVP solver integration tolerances (Absolute)
%% OPTIMIZATION
% inputs.nlpsol.DE.cvarmax=1e-8;            % Stopping criterion: Maximum variance for the population
inputs.nlpsol.DE.itermax = 5000;            % Stopping criterion: Maximum number of iterations                                        Corresponds to NP*itermax function evaluations
% inputs.nlpsol.DE.refresh =10;             % Interval of iterations for displaying results
inputs.nlpsol.nlpsolver='de';              % In this case the problem will be solved with DE
%inputs.nlpsol.nlpsolver='sres';
%inputs.nlpsol.nlpsolver='local_fmincon';

inputs.plotd.plotlevel='medium'; %|'none'|'medium'|'full' % control figure plotting
set(0, 'DefaultFigureVisible', 'off');
