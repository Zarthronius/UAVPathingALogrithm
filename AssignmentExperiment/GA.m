%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% EDITED BY: W20016567
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GA Class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMS:
% 1: POPULATION SIZE
% 2: MUTATION RATE
% 3: TARGET 
% 4: EPOCS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 16/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADDED GA STATISTICS GATHERING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef GA < handle
    properties
        POPULATIONSIZE = 100;
        MUTATIONRATE = 0.01;
%        TARGET = Minimum Distance
        GADATA
        EPOC = 0;
        ELITE = 0;
        LOGGING=0;
        success = 0;
        bestInd = Individual();
        bestEpoc = 0;
        population = [];
        resultEpoc = 0;
        GASTART; %
        GAENDNODE = 0; %
        MAXDIST = 0%
        MINDIST = 0 %
        GANODEWEIGHT = 0
        EPOCRANGE = 0
        stats;
    end
    methods
        % Start GA
        function obj = GA(ps,mr,data,epoc,elite,logging,gastart,gaendnode,maxdist,mindist,nodeWeight,epocrange) %
          if nargin ~= 0
              obj.POPULATIONSIZE=ps;
              obj.MUTATIONRATE=mr;
              obj.GADATA=data;
              obj.EPOC=epoc;
              obj.ELITE=elite;
              obj.LOGGING=logging;
              obj.GASTART = gastart; %
              obj.GAENDNODE = gaendnode; %
              obj.GANODEWEIGHT = nodeWeight;
              obj.MAXDIST = maxdist;
              obj.MINDIST = mindist;
              obj.EPOCRANGE = epocrange;
              obj.population = Population(data,obj.POPULATIONSIZE);
              [obj.bestInd,~] = fitness(obj.population,data,obj.GASTART,obj.GAENDNODE,obj.MAXDIST,obj.MINDIST,obj.GANODEWEIGHT);
              obj.bestInd.gene = [obj.GASTART(1,1) obj.bestInd.gene]; % Ensure gene begins with start node
              obj.success = 0;
              if (obj.LOGGING==1)
                  obj.population.dump(0,'w');
              end
          end
       end
       % Execute objection
       function obj = execute(obj)
          for i = 1:obj.EPOC
              
             % If no new best fitness for no. of epocs, return best result
             if obj.population.complete(i,obj.bestEpoc,obj.EPOCRANGE)
                obj.resultEpoc = i;
                obj.success = 1;
                return
             end
             % Use elitism or full randomness and perform LOX crossover
             temp1 = selection(obj.GADATA,obj.population,obj.ELITE);   % USE ELITE OR RANDOM
             % Mutate children using mutation rate
             mutate(temp1,obj.MUTATIONRATE);
             % Calculate fitness using path distance and node weighting
             [bestResult,total] = fitness(temp1,obj.GADATA,obj.GASTART,obj.GAENDNODE,obj.MAXDIST,obj.MINDIST,obj.GANODEWEIGHT);           % CHECK FITNESS AND GET STATS          
             % CHECK FITNESS AND GET STATS          
             % If new best result, replace best result
             if bestResult.fitness > obj.bestInd.fitness
                 obj.bestInd = bestResult.copy();
                 obj.bestInd.gene = [obj.GASTART(1,1) obj.bestInd.gene];
                 obj.bestEpoc = i;
             end
             % Return stats and increase current epoc
             obj.stats = [obj.stats; [double(i) double(obj.bestInd.fitness) (double(total)/double(obj.POPULATIONSIZE))]]; % UPDATE STATS
             obj.population = temp1;
             if (obj.LOGGING==1)
                 obj.population.dump(i,'a');
             end
         end
      end
   end
end