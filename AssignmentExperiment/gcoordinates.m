%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: ZAC ALLEN
% DATE: 23/04/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SAMPLE PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
main

genelength = length(experiment.bestInd.gene);
result = zeros(genelength,3);
%row = experiment.bestInd.gene(1,1);
%result(1,:) = GADATA(row,:);



for i = 1:genelength
    row = experiment.bestInd.gene(1,i); %value of 1st col in GADATA
    result(i,:) = GADATA(row,:);
end

x = result(:,2);  %x coords
y = result(:,3);  %y coords

 for i = 1:size(result,1)
     if result(i,1) == 10
         row = i;
     end
 end
 
 result(row+1:end, :) = [ ]  % Deletes all rows after end node

x2 = result(:,2);
y2 = result(:,3);

format compact
scatter(x,y);
hold on
plot(x2,y2,"DisplayName","test line"); %can use plot or scatter
legend
%xlim([0 15]);   %both axis between 0 15
%ylim([0 15]);   
xlabel("x");    %axis labels
ylabel("y");
grid
title("title"); %graph title
hold off