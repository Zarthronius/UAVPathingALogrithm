%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUTHOR: ZAC ALLEN
% DATE: 23/04/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT GMAIN AND PATH PROGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
gmain

figure("Name","Best Path Mapped");
% Path coordinates
xpath = result(:,2);
ypath = result(:,3);

format compact
% Plot Nodes
scatter(xall,yall,"DisplayName", "Nodes");
hold on
% Path plot
plot(xpath,ypath,"DisplayName","Path Taken"); 
legend
% Axis labels
xlabel("x");    
ylabel("y");
grid
% Graph title
title("GA best path taken", ["MINPATH" num2str(MINDIST) " MAX PATH " num2str(MAXDIST) " NODE WEIGHT: " num2str(GANODEWEIGHT)]); 
hold off