clear
close all
clc

% Berfungsi untuk menghasil feature data set

[FileName,PathName,~] = uigetfile('*.MAT', 'Pilih File-file hypercube yang akan diekstrak cirinya', 'MultiSelect', 'on');
if isequal(FileName, 0)
    msgbox('Pembatalan dilakukan', 'Canceled');
    return
end

iCrop = 0;
for iFile=1:size(FileName,2)
    dataNow = load([PathName FileName{iFile}]);
    cropTrans = dataNow.cropTransmittance;
    for i=1:size(cropTrans)
        iCrop = iCrop+1;
    end
end

cropTransmittance     = zeros(iCrop,448);
object              = cell(iCrop,1);
kelas_1             = cell(iCrop,1);
kelas_2             = cell(iCrop,1);
atribut_1_name      = cell(iCrop,1);
atribut_1_val       = zeros(iCrop,1);
atribut_1_units     = cell(iCrop,1);
atribut_2_name      = cell(iCrop,1);
atribut_2_val       = zeros(iCrop,1);
atribut_2_units     = cell(iCrop,1);
atribut_3_name      = cell(iCrop,1);
atribut_3_val       = zeros(iCrop,1);
atribut_3_units     = cell(iCrop,1);
% atribut_4_name      = cell(iCrop,1);
% atribut_4_val       = zeros(iCrop,1);
% atribut_4_units     = cell(iCrop,1);
iCrop               = 1;

for iFile=1:size(FileName,2)
    dataNow     = load([PathName FileName{iFile}]);
    annotation  = dataNow.annotation;
    cropTrans     = dataNow.cropTransmittance;
    for i=1:size(cropTrans,1)
        % Feature extraction
        targets = mean(cropTrans{i},1);
        targets = mean(targets,2);
        targets = squeeze(targets);
        cropTransmittance(iCrop,:) = targets;
       
        
        kelas_1{iCrop} = upper(annotation.kelas_1);
        
         kelas_2{iCrop} = upper(annotation.kelas2);
         atribut_1_name{iCrop} = upper(annotation.atribut1_Str);
         atribut_2_name{iCrop} = upper(annotation.atribut2_Str);
         if isfield(annotation, 'atribut3_Str')
             atribut_3_name{iCrop} = upper(annotation.atribut3_Str);
         end
%         if isfield(annotation, 'atribut4_Str')
%             atribut_4_name{iCrop} = upper(annotation.atribut4_Str);
%         end
         atribut_1_val(iCrop) = annotation.valAtribut1;
         atribut_2_val(iCrop) = annotation.valAtribut2;
         if isfield(annotation, 'valAtribut3')
             atribut_3_val(iCrop) = annotation.valAtribut3;
         end
%         if isfield(annotation, 'valAtribut3')
%             atribut_4_val(iCrop) = annotation.valAtribut3;
%         end
        iCrop = iCrop+1;
    end
end

uisave({'cropTransmittance', ...
    'kelas_1', 'kelas_2', ...
    'atribut_1_name', 'atribut_2_name', 'atribut_3_name', ...
    'atribut_1_val', 'atribut_2_val', 'atribut_3_val'}, ...
    [PathName '.mat']);

disp('Selesai');