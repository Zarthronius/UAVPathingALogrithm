%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: DR N ELIOT
% DATE: 15/10/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Population Class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef Population < handle
    properties
        table
        individuals
    end
    methods
        function obj = Population(data,num)
            if nargin > 0
                obj.table = data;
                for c = 1:num
                     a = Individual(shuffle(data));
                     obj.individuals = [obj.individuals; a];
                end
            end
        end
        function obj = add(obj,val)
            obj.individuals = [obj.individuals; val];
        end
        function obj = print(obj)
            for i = 1:size(obj.individuals,1)
                obj.individuals(i).print();
            end
        end
        function result = complete(obj, currentEpoc, bestEpoc)
            % No exit condition specified. i.e. run to the end of the epocs!
            % There should really be a check that the distance has stabalised.
            result=0;
            
            if (currentEpoc - bestEpoc) > 200  %% If no new best solution
                result = 1;                    %% for 250 epocs
            end                                %% end experiment
        end
        function dump(obj,data,mode)
            fileID = fopen('experiment.txt',mode);
            fprintf(fileID,"GENERATION: %d\n",data);
            for i = 1:size(obj.individuals,1)
                g = obj.individuals(i).gene;
                fprintf(fileID,"[%d] %s",obj.individuals(i).fitness,evalc('disp(g)'));
            end
            fclose(fileID);
        end
    end
end