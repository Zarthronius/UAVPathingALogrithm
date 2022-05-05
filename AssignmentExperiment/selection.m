%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% EDITED BY: W20016567
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selection Function which includes crossover
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TAKES TOP 2 INDIVIDUALS AS PARENTS AND CARRIES THEM FORWARD.
% CREATES TWO CHILD FROM THOSE TWO PARENTS (MUTATED) AND ADDS THEM TO THE POPULATION
% USES RANDOM SELECTION TO CREATE THE REMAINDER OF THE POPULATION USING TWO PARENTS TO 
% CREATE A SINGLE MUTATED CHILD WHICH IS THEN ADDED TO THE POPULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERSION 0.1
% DATE: 16/10/2021
% Altered selection to include 2 children from parents
% parent1(parent2) and parent2(parent1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATE: 16/10/2021
% Added selection of ELITISM OR RANDOM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function newpop = selection(data,pop,elite)
    newpop = Population(data,0);              % Next generation
    sortedpop  = Population(data,0);          % Temp Population

    [~,ind] = sort([pop.individuals.fitness],'ascend');  % Get sort index for fittest
    sortedpop.individuals = pop.individuals(ind);        % Create sorted list (not really needed could use index directly)

       RANDOMAREA = 1; % ALL POPULATION
%      RANDOMAREA = 2; % TOP HALF
%      RANDOMAREA = 4; % TOP QUARTER
    if (elite==1)
% ================ ELTISM START =================    
        newpop.add(sortedpop.individuals(1));                                  % Save Parent 1 (Elitism)
        newpop.add(sortedpop.individuals(2));                                  % Save Parent 2 (Elitism)
        child1 = sortedpop.individuals(1).crossing(sortedpop.individuals(2));        % Create a child
        child2 = sortedpop.individuals(2).crossing(sortedpop.individuals(1));        % Create a child
        newpop.add(child1);
        newpop.add(child2);
        % select random parents and create more children;
        for i = 5:size(sortedpop.individuals,1)
            parent1 = sortedpop.individuals(randi(cast(size(sortedpop.individuals,1)/RANDOMAREA,'uint64')));
            parent2 = sortedpop.individuals(randi(cast(size(sortedpop.individuals,1)/RANDOMAREA,'uint64')));
            child1 = parent1.crossing(parent2);
            newpop.add(child1);   
        end
% ==================== ELITISM END ================
    else
% ==================== RANDOM TOP START ===============
      for i = 1:size(pop.individuals,1)
          parent1 = pop.individuals(randi(cast(size(pop.individuals,1)/RANDOMAREA,'uint64'))); %Take from a portion
          parent2 = pop.individuals(randi(cast(size(pop.individuals,1)/RANDOMAREA,'uint64'))); %Take from a portion
          child1 = parent1.crossing(parent2);
          newpop.add(child1);    
      end
% ==================== RANDOM TOP END =================
    end
end