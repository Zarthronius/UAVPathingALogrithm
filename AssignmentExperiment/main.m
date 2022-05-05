clc;
clear;
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AUTHOR = "AUTHOR: DR N ELIOT";
DATE = "DATE: 13/11/2021";
VERSION="TSP2 0.02";
% AUTHOR: DR N ELIOT";
% EDITED BY: W20016567
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GA TSP PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATES A GA OBJECT AND TIMES THE OPERATION
% POPULATION MUST BE > 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 25/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDED ELITE SELECTION IN GA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 01/11/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDED POPULATION LOGGING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Population Size
GAPOPULATIONSIZE=500;
% Mutation Rate
GAMUTATIONRATE=1.0;
% Start node
GASTART = [1 2 3];
% Matrix of nodes
GADATA = readmatrix('coords');
% End node ID
GAENDNODE = 8; %
% Appends start node to the rest of the data
GADATAFULL = [GASTART; GADATA]; %
% Maximum and minimum possible flight distances
MAXDIST = 100; %
MINDIST = distance(GADATAFULL,1,GAENDNODE);%
GANODEWEIGHT = 0.001;%

% remember n! possible answers
% Number of epocs
GAEPOC=500;
 % Stops after number of epocs with no improvement
GAEPOCRANGE = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELITE=1; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOGGING=0; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("+------------------------------------------------------+\n");
fprintf("| %s\n",AUTHOR);
fprintf("| %s\n",DATE);
fprintf("+------------------------------------------------------+\n");
if ELITE == 1
  fprintf("| GENETIC ALGORITHM WITH ELITISM    (VERSION:%s)|\n",VERSION);
else
  fprintf("| GENETIC ALGORITHM WITHOUT ELITISM (VERSION:%s) |\n",VERSION);
end
fprintf("+------------------------------------------------------+\n");
fprintf("POPULATION = %d\n",GAPOPULATIONSIZE);
fprintf("MUTATION RATE = %f\n",GAMUTATIONRATE);
fprintf("EPOC = %d\n",GAEPOC);
fprintf("--------------------------------------------------------\n");
tic
experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC,ELITE,LOGGING,GASTART,GAENDNODE,MAXDIST,MINDIST,GANODEWEIGHT,GAEPOCRANGE);
build = toc;
fprintf("BUILD TIME: %fs\n", build);
tic
experiment.execute();
exprun = toc;
fprintf("EXCUSION TIME: %fs\n", exprun);
fprintf("TOTAL TIME: %fs\n", build+exprun);
fprintf("====================================================\n");

    %% removes excess nodes after path and gets coordinates for mapping
    genelength = length(experiment.bestInd.gene);
    result = zeros(genelength,3);
    for i = 1:genelength
        row = experiment.bestInd.gene(1,i); %value of 1st col in GADATA
        result(i,:) = GADATAFULL(row,:);
    end    
    xall = GADATAFULL(:,2);  %x coords
    yall = GADATAFULL(:,3);  %y coords
    
    for i = 1:size(result,1)
        if result(i,1) == GAENDNODE
            row = i;
        end
    end

    result(row+1:end, :) = [ ]; %
    resultgene(1,:) = result(:,1); %

if experiment.success
    fprintf("SUCCESSFUL RUN!\n");
    fprintf("TARGET FOUND IN EPOC: %d\n",experiment.resultEpoc);
else
    fprintf("BEST ANSWER ONLY! (EPOC: %d)\n",experiment.bestEpoc);
end
fprintf("[%s]%s",num2str(experiment.bestInd.fitness),evalc('disp(resultgene)'));
fprintf("====================================================\n");




