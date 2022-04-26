%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: ZAC ALLEN
% DATE: 23/04/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SAMPLE PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
main

xpath = result(:,2);
ypath = result(:,3);

format compact
scatter(xall,yall,"DisplayName", "Nodes");
hold on
plot(xpath,ypath,"DisplayName","Path Taken"); %can use plot or scatter
legend
%xlim([0 15]);   %both axis between 0 15
%ylim([0 15]);   
xlabel("x");    %axis labels
ylabel("y");
grid
title("GA best path taken"); %graph title
hold off