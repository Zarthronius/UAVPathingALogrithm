%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Individiual Class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Individual < handle
    properties
        gene
        fitness = 0;
        valid = 1; %
        visited = 0; %
        endDist = 0;
    end
    methods
        function obj = Individual(val,fit)
            if nargin == 0
            elseif nargin == 1
                obj.gene = val;
                obj.valid = 1; %
                obj.visited = 0; %
                obj.endDist = 0;
            elseif nargin == 2
                obj.gene = val;
                obj.valid = 1; %
                obj.visited = 0; %
                obj.endDist = 0; %
                obj.fitness = fit;
                
            end
        end
        %% 
        function obj = check(obj,data,gastart,gaendnode,maxDist,minDist)               % allows fitness 
            if nargin ~= 0
                obj.valid = 1;
                obj.visited = 0;
                dist = 0;
                                                                            % to be applied
                
                newdata = [gastart; data];
                newgene = [gastart(1,1) obj.gene];

                assert(maxDist > minDist, 'maximum distance must be larger than distance between start and end node') %ensure journey is possible

                for i = 1:size(newgene,2)-1
                    obj.visited = obj.visited + 1;
                    dist = dist + distance(newdata,newgene(i),newgene(i+1));
                
                    if dist < maxDist                   
                        if newgene(i+1) == gaendnode    %stop searching when node found
                            break
                        end
                    else 
                        obj.valid = 0;                  %returns invalid run if too short
                        continue
                    end
                end

                if obj.valid == 1
                    obj.endDist = dist;
                    obj.fitness = dist - (obj.visited * 20); % improves fitness by 20 for each location visited BREAKS IF TOO LOW
                end
            end
        end
        %%
        function child = crossing(obj,val)              % Simple LOX crossover
            child = Individual();                       % create a child
            cross = cast(size(obj.gene,2)/2,'uint64');        % get mid point
            child.gene = obj.gene(1:cross);
            for i = 1:size(val.gene,2)
                if ~ismember(val.gene(i),child.gene)
                    child.gene = [child.gene val.gene(i)];            
                end
            end
        end
        function obj = mutate(obj,mrate)         % mutate the gene (exchange 2 random genes)
            if (rand < mrate)
                pos1 = randi(size(obj.gene,2)); 
                pos2 = randi(size(obj.gene,2));
                temp = obj.gene(pos1);
                obj.gene(pos1) = obj.gene(pos2);
                obj.gene(pos2) = temp;
            end
        end
        function ind = copy(obj)              % deep copy and individual
            ind = Individual(obj.gene);
            ind.fitness = obj.fitness;
            ind.visited = obj.visited; %
            ind.endDist = obj.endDist;
        end
        function obj = print(obj)
            fprintf("[%s]%s",num2str(obj.fitness),evalc('disp(obj.gene)'));
        end
    end
end