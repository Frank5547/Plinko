%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATH 4080 Final Exam
% Plinko (Bean Machine) Simulation e)) In this simulation only one wall is not
% reflective. If the chip hits this wall it is out of play.
% Francisco Javier Carrera Arias
% 12/01/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;

% Step 1: Generate a Plinko board as a cell array
a = [0,0,0,0,0,0,0,0,0];
b = [0,0,0,0,0,0,0,0];
c = [0,0,0,0,0,0,0,0,0];
d = [0,0,0,0,0,0,0,0];
e = [0,0,0,0,0,0,0,0,0];
f = [0,0,0,0,0,0,0,0];
g = [0,0,0,0,0,0,0,0,0];
h = [0,0,0,0,0,0,0,0];
i = [0,0,0,0,0,0,0,0,0];
j = [0,0,0,0,0,0,0,0];
k = [0,0,0,0,0,0,0,0,0];
l = [0,0,0,0,0,0,0,0];
bins = [0,0,0,0,0,0,0,0,0];
cell = {a,b,c,d,e,f,g,h,i,j,k,l,bins};
cellCopy = cell;
counter = [0,0,0,0,0,0,0,0,0];
valueVec = [100,500,1000,0,10000,0,1000,500,100];

%% Plinko Chip flow loop
rng(1)
initLoc = 7; % Set the Initial Location of the chip (Change from 1:9 to see the different distributions)
for k = 1:100
    cell = cellCopy;
    location = initLoc;
    cell{1}(location) = 1; % Chip starts at the fifth location (the middle)
    for i = 2:13
        if mod(i-1,2) ~= 0 && location == 1
            cell{i}(location) = 0;
            location = 0;
            break;  % In this simulation, only the left wall is an absorbing wall
        elseif mod(i-1,2) ~= 0 && location == 9
            cell{i}(location-1) = 1;
        end
        if mod(i-1,2) ~= 0 && location ~= 1 && location ~= 9
            cell{i}(location) = binornd(1,0.5);
            cell{i}(location-1) = binornd(1,0.5);
            while cell{i}(location) == 0 && cell{i}(location-1) == 0 || cell{i}(location) == 1 && cell{i}(location-1) == 1
                  cell{i}(location) = binornd(1,0.5);
                  cell{i}(location-1) = binornd(1,0.5);
            end
        end
        if mod(i-1,2) == 0
            cell{i}(location) = binornd(1,0.5);
            cell{i}(location+1) = binornd(1,0.5);
            while cell{i}(location) == 0 && cell{i}(location+1) == 0 || cell{i}(location) == 1 && cell{i}(location+1) == 1
                  cell{i}(location) = binornd(1,0.5);
                  cell{i}(location+1) = binornd(1,0.5);
            end
        end
        location = find(cell{i},1);
    end
   if location == 0
            counter = counter + 0;
   elseif initLoc == 1
       counter(1) = 0;
   elseif location ~= 0
       counter(location) = counter(location) + 1;
   end
end

disp(counter)

%% Plot the Distribution
plot(counter);
str = sprintf('Distribution of values with the chip starting on position %d',initLoc);
title(str);
xlabel('Value (in $US)')
ylabel('Number of Occurences')
xticklabels(string(valueVec))

%% Mean winnings and standard deviation based on initial positioning of the chip
Avg = mean(counter.*valueVec);
Sd = std(counter.*valueVec);
fprintf('The average winnings from position %d is $%.2f. The standard deviation is $%.2f\n',initLoc, Avg,Sd)