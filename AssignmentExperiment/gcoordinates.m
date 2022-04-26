%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: ZAC ALLEN
% DATE: 23/04/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SAMPLE PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
main
format compact
scatter(xall,yall);
hold on
plot(xall,yall,"DisplayName","test line"); %can use plot or scatter
legend
%xlim([0 15]);   %both axis between 0 15
%ylim([0 15]);   
xlabel("x");    %axis labels
ylabel("y");
grid
title("title"); %graph title
hold off