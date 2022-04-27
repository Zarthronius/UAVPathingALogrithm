%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fitness Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fittestInd,total] = fitness(pop,data,gastart,gaendnode,maxdist,mindist)
    fittestInd = Individual([],0); % Create temp Individual with a 0 value 
                                   % fitness
    total = 0;
    for i = 1:size(pop.individuals,1)
        pop.individuals(i).check(data,gastart,gaendnode,maxdist,mindist);
        if pop.individuals(i).valid == 1
            if (pop.individuals(i).fitness > fittestInd.fitness)
               fittestInd = pop.individuals(i).copy();
            end
        end
        total = total + pop.individuals(i).fitness;
    end
end
