%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fitness Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fittestInd,total] = fitness(pop,data)
    fittestInd = Individual([],realmax); % Create temp Individual with a max value fitness
                                         % value. This can be avoided by using an
                                         % inverse fitness function so we could sort decending.
                                         % but it's fine for now!
    total = 0;
    for i = 1:size(pop.individuals,1)
        pop.individuals(i).check(data);
        if (pop.individuals(i).fitness < fittestInd.fitness)
           fittestInd = pop.individuals(i).copy();
        end
        total = total + pop.individuals(i).fitness; 
    end
end
