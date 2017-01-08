%  HUMAN TEST SCRIPT %
% requires humanTest.m
clear;
clc;

howManyYouCanBeBotheredToDo = 5;

load emotions_data;

[xShuff, yShuff] = zipShuffSplit(x,y);
xShuffTruncated = xShuff(1:howManyYouCanBeBotheredToDo,:);
yShuffTruncated = yShuff(1:howManyYouCanBeBotheredToDo,:);


yourAccuracy = humanTest(xShuffTruncated, yShuffTruncated);

disp(strcat('Your accuracy was: ...' , int2str(round(yourAccuracy)),'%'));