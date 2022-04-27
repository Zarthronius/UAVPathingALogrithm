%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fitness Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fittestInd,total] = fitness(pop,data,gastart,gaendnode,maxdist,mindist,nodeWeight)
    fittestInd = Individual([],0); % Create temp Individual with a 0 value 
                                   % fitness
   newdata = [gastart; data]; %
    total = 0;
    for i = 1:size(pop.individuals,1)
        newgene = [gastart(1,1) pop.individuals(i).gene]; %
        pop.individuals(i).check(newdata,newgene,gaendnode,maxdist,mindist,nodeWeight);
        if pop.individuals(i).valid == 1
            if (pop.individuals(i).fitness > fittestInd.fitness)
               fittestInd = pop.individuals(i).copy();
            end
        end
        total = total + pop.individuals(i).fitness;
    end
end
