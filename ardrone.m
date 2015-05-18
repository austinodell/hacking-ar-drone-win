function [ output ] = setup( input )
%SETUP Summary of this function goes here
%   Detailed explanation goes here

if exist('input','var')
    if strcmp(input,'--help')
        help
    elseif strcmp(input,'--install')
        install
    elseif strcmp(input,'--uninstall')
        uninstall
    elseif strcmp(input,'--example')
        example
    else
        disp('Invalid input provided, please use --help to see options');
    end
else
    disp('No input provided, please use --help to see options');
end

end

function help

fprintf('usage: ardrone [--help] [--install] [--uninstall] [--example]\n');

end

function install

fprintf('Beginning setup for AR Drone 2.0 Toolchain...\n');

uninstall;

fprintf('Creating folder...');
[mks,mkmess,mkmessid] = mkdir('c:/matlab','ardrone');
fprintf('done\n');

fprintf('Extracting files to location...');
unzip('support_files','c:/matlab/ardrone');
fprintf('done\n');

%fprintf('Copying files...');
%[cps,cpmess,cpmessid] = copyfile('matlab_files/*','c:/matlab/ardrone');
%fprintf('done\n');

fprintf('Adding to path...');
addpath('c:/matlab/ardrone');
fprintf('done\n');

end

function uninstall

previous = exist('c:/matlab/ardrone');

if(previous == 7)
    fprintf('Removing old installation...');
    rmpath('c:/matlab/ardrone');
    rmdir('c:/matlab/ardrone','s');
    fprintf('done\n');
elseif(previous ~= 0)
    fprintf('Removing old failed installation...');
    rmpath('c:/matlab/ardrone');
    delete('c:/matlab/ardrone');
    fprintf('done\n');
end

end

function example

fprintf('Note:\tYou must have a MATLAB-compatible C++ compiler installed\n\t\tand set up (can be set up using command "mex --setup C++")\n\t\tto use this toolchain.\n\n');

fprintf('1.\tCreate a simulink model.\n');
fprintf('2.\tIn "Model Configuration Parameters",\n\tselect "Code Generation" and\n\tchange the "System target file" to ard.tlc\n');
fprintf('3.\tChange "Language" to C++\n');
fprintf('4.\tIn "Interface", change the "Interface" option to "External mode"\n');
fprintf('5.\tChange the "Transport layer" to "tcpip"\n');
fprintf('6.\tChange the "MEX-file arguments" to "''192.168.1.1'' 1 17725"\n');
fprintf('7.\tIn "Simulation Target>Custom Code", in\n\t"Include custom C code in generated",\n\tadd the following to "Header file":\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/motorboard.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/mot.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/util.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/gpio.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/type.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/navcontrol.h"\n');
fprintf('\t\t#include "C:/MATLAB/ardrone/c_library/navboard.h"\n');
fprintf('8.\tIn "Include list of additional",\n\tadd the following to "Source file":\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/motorboard.c"\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/mot.c"\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/util.c"\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/gpio.c"\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/navcontrol.c"\n');
fprintf('\t\t"C:/MATLAB/ardrone/c_library/navboard.c"\n');
fprintf('9.\tIn "Solver" change "Solver Options" Type to "Fixed-step"\n\tand "Solver" to "discrete (no continuous states" with a\n\t"Fixed-step size" of .1\n');
fprintf('10.\tThen you can build and run!\n');

end