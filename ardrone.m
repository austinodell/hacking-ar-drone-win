function setup( input )

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

fprintf('Beginning setup for AR Drone 2.0 Toolchain...\n\n');

uninstall;

fprintf('Creating folder...');
[mks,mkmess,mkmessid] = mkdir('c:/matlab','ardrone');
fprintf('done\n\n');

fprintf('Downloading support package installer...');
%url ='http://drone.austinodell.com/support_files.zip';
%urlspec ='http://www.mathworks.com/matlabcentral/fileexchange/downloads/63772/akamai/armcortexadst.mlpkginstall';
url ='http://www.mathworks.com/matlabcentral/fileexchange/48010?download=true';
urlwrite(url,'armcortexadst.mlpkginstall');
fprintf('done\n\n');

fprintf('Opening support package installer...');
open('armcortexadst.mlpkginstall');
fprintf('done\n\n');

v = version('-release');
path = ['c:/matlab/supportpackages/r' v '/'];
[pathstr,name,ext] = fileparts(path);
disp(['Note: Install support package to default directory (' pathstr ').']);

fprintf('Waiting for support package to install...');
while(wait_for_support_package(pathstr) == 0)
    pause(1);
end
fprintf('done\n\n');

fprintf('Downloading support files...');
%url ='https://github.com/austinodell/hacking-ar-drone-win/blob/master/support_files.zip?raw=true';
url ='https://github.com/austinodell/hacking-ar-drone-win/archive/master.zip';
loc = urlwrite(url,'support_files.zip');
fprintf('done\n\n');

fprintf('Extracting files to location...');
unzip(loc,'c:/matlab/ardrone');
fprintf('done\n\n');

fprintf('Adding to path...');
addpath(genpath('c:/matlab/ardrone'));
fprintf('done\n\n');

fprintf('Cleaning up...');
delete('support_files.zip');
delete('armcortexadst.mlpkginstall');
fprintf('done\n\n');

fprintf('You have successfully installed the AR Drone toolchain!\n');

end

function result = wait_for_support_package(pathstr)
    result = 0;
    
    directory = dir(pathstr);
    for i=1:size(directory,1)
        if regexp(directory(i).name, regexptranslate('wildcard','Linaro-Toolchain-*'))
            result = 1;
            return
        end
    end
end

function uninstall

previous = exist('c:/matlab/ardrone');

if(previous == 7)
    fprintf('Removing path...');
    rmpath(genpath('c:/matlab/ardrone'));
    fprintf('done\n');
    fprintf('Removing old installation...');
    rmdir('c:/matlab/ardrone','s');
    fprintf('done\n');
elseif(previous ~= 0)
    fprintf('Removing path...');
    rmpath(genpath('c:/matlab/ardrone'));
    fprintf('done\n');
    fprintf('Removing old failed installation...');
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