%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
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
        stats;
    end
    methods
        function obj = GA(ps,mr,data,epoc,elite,logging,gastart,gaendnode,maxdist,mindist) %
          if nargin ~= 0
              obj.POPULATIONSIZE=ps;
              obj.MUTATIONRATE=mr;
              obj.GADATA=data;
              obj.EPOC=epoc;
              obj.ELITE=elite;
              obj.LOGGING=logging;
              obj.GASTART = gastart; %
              obj.GAENDNODE = gaendnode; %
              obj.MAXDIST = maxdist;
              obj.MINDIST = mindist;
              obj.population = Population(data,obj.POPULATIONSIZE);
              [obj.bestInd,~] = fitness(obj.population,data,obj.GASTART,obj.GAENDNODE,obj.MAXDIST,obj.MINDIST);
              obj.success = 0;
              if (obj.LOGGING==1)
                  obj.population.dump(0,'w');
              end
          end
       end
       function obj = execute(obj)
          for i = 1:obj.EPOC
              
             if obj.population.complete(i,obj.bestEpoc)
                obj.resultEpoc = i;
                obj.success = 1;
                return
             end
             temp1 = selection(obj.GADATA,obj.population,obj.ELITE);   % USE ELITE OR RANDOM
             mutate(temp1,obj.MUTATIONRATE);
            
            %TODO: something here to shuffle?

             [bestResult,total] = fitness(temp1,obj.GADATA,obj.GASTART,obj.GAENDNODE,obj.MAXDIST,obj.MINDIST);           % CHECK FITNESS AND GET STATS
             if bestResult.fitness > obj.bestInd.fitness
                 obj.bestInd = bestResult.copy();
                 obj.bestInd.gene = [obj.GASTART(1,1) obj.bestInd.gene];
                 obj.bestEpoc = i;
             end
             obj.stats = [obj.stats; [double(i) double(obj.bestInd.fitness) (double(total)/double(obj.POPULATIONSIZE))]]; % UPDATE STATS
             obj.population = temp1;
             if (obj.LOGGING==1)
                 obj.population.dump(i,'a');
             end
         end
      end
   end
end