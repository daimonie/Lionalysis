%% VB-HMM analysis parameter file generated by vbSPTgui %%

% Fredrik Persson & Martin Linden 2012-06-13

% This is a GUI generated HMM analysis runinput file, which specifies
% everything the code needs to know about how to analyze a particular data
% set.
% To run the HMM analysis manually type:
% >> VB3_HMManalysis('runinputfilename')

jobID = 'Tus-PAmCherry OriC '; % CHANGE THIS EACH EXP

%select the main directory of the experiment containing the '1' '2'
%experiment that contain the "stacks" and "utrackResults" folders
dataDirectory = uigetdir(pwd,'Select Data Directory');

%adding a trailing slash
dataDirectory = sprintf('%s%s', dataDirectory,'/');

% Inputs
inputfile = sprintf('%s%s',dataDirectory,'Results/Traj.mat');
trajectoryfield = 'Traj';

% Computing strategy
parallelize_config = 1;
parallel_start = 'theVBpool=gcp';  % executed before the parallelizable loop.
parallel_end = 'delete(theVBpool)'; % executed after the parallelizable loop.
% Saving options

outputfile = sprintf('%s%s%s%s',dataDirectory,'Results/VB3_Results/',jobID,'.mat');

% Data properties
timestep = 0.02;     % in [s]
dim = 2;
trjLmin = 4;
umperpx=0.159; %0.159 for real imaging 0.08 for simulation

% Convergence and computation alternatives
runs = 50;
maxHidden = 2; % Maximum number of states to consider!

% Evaluate extra estimates including Viterbi paths
stateEstimate = 0;

maxIter = [];    % maximum number of VB iterations ([]: use default values).
relTolF = 1e-8;  % convergence criterion for relative change in likelihood bound.
tolPar = [];     % convergence criterion for M-step parameters (leave non-strict).

% Bootstrapping
bootstrapNum = 100;
fullBootstrap = 1;

% Limits for initial conditions
init_D = [0.001, 1];   % interval for diffusion constant initial guess [length^2/time] in same length units as the input data.
init_tD = [1, 10]*timestep;     % interval for mean dwell time initial guess in [s].

% It is recommended to keep the initial tD guesses on the lower end of the expected spectrum.

% Prior distributions
% The priors are generated by taking the geometrical average of the initial guess range.
% units: same time units as timestep, same length unit as input data.
prior_type_D = 'mean_strength';
prior_D = 1;         % prior diffusion constant [length^2/time] in same length units as the input data.
prior_Dstrength = 5;   % strength of diffusion constant prior, number of pseudocounts (positive).

%% default prior choices (according nat. meth. 2013 paper)
prior_type_Pi = 'natmet13';
prior_piStrength = 5;  % prior strength of initial state distribution (assumed uniform) in pseudocounts.',...
prior_type_A = 'natmet13';
prior_tD = 10*timestep;      % prior dwell time in [s].',...
prior_tDstrength = 2*prior_tD/timestep;  % transition rate strength (number of pseudocounts). Recommended to be at least 2*prior_tD/timestep.',...

%% new prior choices (for advanced users, as they are not yet systematically tested)',...
%prior_type_Pi = 'flat';
%prior_type_A = 'dwell_Bflat';
%prior_tD = 10*timestep;      % prior dwell time in [s]. Must be greater than timestep (recommended > 2*timestep)
%prior_tDstd = 100*prior_tD;  % standard deviation of prior dwell times [s].
