clc
clear 
close all

% if exist('temporary.mat', 'file')
%     load temporary.mat;
% else
%     msgbox('Error: temporary.mat is not found. Run "Read Data" First', 'Error','error');
%     return;
% end
load T_V_Madu_1.mat;

rgbBands        = [122,76,39];
tColor(:,:,1)   = Transmittance(:,:, rgbBands(1));
tColor(:,:,2)   = Transmittance(:,:, rgbBands(2));
tColor(:,:,3)   = Transmittance(:,:, rgbBands(3));

tColor          = imadjust(tColor, stretchlim(tColor));

imshow(tColor);
imwrite(tColor,'T_V_Madu_1_Corrected.png')




%%%%%%%%%%%%%%%%%%%%% PEMILIHAN ROI %%%%%%%%%%%%%%%%%%%%
jumlahCrop  = 10;   %%%% Masukkan jumlah crop yang akan diambil
widthCrop   = 10;  %%%% Masukkan lebar kotak crop yang akan diambil
heightCrop  = 10;  %%%% Masukkan tinggi kotak crop yang akan diambil
[heightT, widthT, ~] = size(Transmittance);


shiftCrop   = 0;
hCrop       = cell(jumlahCrop,1);
for iCrop=1:jumlahCrop
    hCrop{iCrop}    = imrect(gca, [((.5*widthT)+shiftCrop) (.5*heightT) widthCrop heightCrop]);
    shiftCrop       = shiftCrop+widthCrop+10;
    pT = getPosition(hCrop{iCrop});
    text(pT(1,1)+15, pT(1,2)+15, num2str(iCrop), 'color', 'w','Tag', ['rectLabel' num2str(iCrop)]);
    addNewPositionCallback(hCrop{iCrop},@(p) textMove(p,iCrop));
    fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
    setPositionConstraintFcn(hCrop{iCrop},fcn);
    setResizable(hCrop{iCrop},0);
end

disp('Pindahkan ROI ke area yang akan dicrop');
disp('Tekan Enter di Command Windows jika sudah selesai');
pause;

cropTransmittance = cell(size(hCrop,1),1);
bandSize        = size(Transmittance,3);

for iCrop=1:size(hCrop,1)
    rect    = getPosition(hCrop{iCrop});
    cropT   = imcrop(tColor, rect);
    cropT   = zeros(size(cropT,1), size(cropT,2), bandSize);
    for i=1:bandSize
        cropT(:,:,i) = imcrop(Transmittance(:,:,i), rect);
    end
    cropTransmittance{iCrop} = cropT;
end

annotation.kelas_1 = 'Al Mubarak';                   %%Kelas 1
annotation.kelas2 = 'Kopi';                     %%Kelas 2
annotation.atribut1_Str = 'Brix';    %%Jenis Atribut 1 in English
annotation.atribut2_Str = 'pH';               %%Jenis Atribut 2
annotation.atribut3_Str = 'EC';               %%Jenis Atribut 3
% annotation.atribut4_Str = '';               %%Jenis Atribut 4
annotation.valAtribut1 = 79.6 ;              %% Nilai Atribut 1 
annotation.valAtribut2 = 3.6 ;                %% Nilai Atribut 2
annotation.valAtribut3 = 126 ;                %% Nilai Atribut 2
% annotation.valAtribut4 = 0 ;                %% Nilai Atribut 2

uisave({'cropTransmittance', 'annotation', 'info'}, [info.filename '.mat']);
disp('Data telah disimpan');