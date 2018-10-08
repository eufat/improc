clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%LOAD FILE%%%%%%%%%%%%%%%%%%%%

parentpath = cd(cd('..'));
addpath([parentpath '\Envi']);


% White Calibration
filenameWhite    = 'FullWhite_3';
hdrfileWhite     = [parentpath '\Data fix\' filenameWhite '\capture\' filenameWhite '.hdr'];
datafileWhite    = [parentpath '\Data fix\' filenameWhite '\capture\' filenameWhite '.raw'];

% Dark Calibration
filenameDark    = 'Dark_2';
hdrfileDark     = [parentpath '\Data fix\' filenameDark '\capture\' filenameDark '.hdr'];
datafileDark    = [parentpath '\Data fix\' filenameDark '\capture\' filenameDark '.raw'];

% Data
filename    = 'T_V_Madu_5';
hdrfile     = [parentpath '\Data fix\' filename '\capture\' filename '.hdr'];
datafile    = [parentpath '\Data fix\' filename '\capture\' filename '.raw'];

%%%%%%%%%%%%%%%%%%%%% KOREKSI SPEKTRAL %%%%%%%%%%%%%%%%%%%%

% save('dataHSI', 'DWhite', 'DDark', 'D', 'info');

[DWhite,infoWhite]      = enviread(datafileWhite,hdrfileWhite);
[DDark,infoDark]        = enviread(datafileDark,hdrfileDark);
[D,info]                = enviread(datafile,hdrfile);


Transmittance                     = rdivide((D-DDark),(DWhite-DDark));
Transmittance(isnan(Transmittance)) = 0;
Transmittance(isinf(Transmittance)) = 0;

info.filename = filename;

save('T_V_Madu_5.mat', 'Transmittance', 'info');
display('proses selesai');