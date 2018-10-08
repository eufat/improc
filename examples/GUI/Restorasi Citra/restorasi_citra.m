function restorasi_citra
f = figure('Name','Restorasi Citra','MenuBar','none',...
    'ToolBar','none','NumberTitle','off','Position',[250 130 800 500]);

tgroup = uitabgroup('Parent', f);
tab1 = uitab('Parent', tgroup, 'Title', 'Model Derau Aditif');
tab2 = uitab('Parent', tgroup, 'Title', 'Restorasi Derau secara Spasial');
tab3 = uitab('Parent', tgroup, 'Title', 'Restorasi Derau Periodik');
tab4 = uitab('Parent', tgroup, 'Title', 'Inverse Filter');
tab5 = uitab('Parent', tgroup, 'Title', 'Pseudo-Inverse Filter');
tab6 = uitab('Parent', tgroup, 'Title', 'Filter Wiener');

tgroup1 = uitabgroup('Parent', tab1);
tgroup2 = uitabgroup('Parent', tab2);
tgroup3 = uitabgroup('Parent', tab3);

tab1a = uitab('Parent', tgroup1, 'Title', 'Citra Asli');
tab1b = uitab('Parent', tgroup1, 'Title', 'Derau Impuls');
tab1c = uitab('Parent', tgroup1, 'Title', 'Derau Uniform');
tab1d = uitab('Parent', tgroup1, 'Title', 'Derau Gaussian');
tab1e = uitab('Parent', tgroup1, 'Title', 'Derau Rayleigh');

tab2a = uitab('Parent', tgroup2, 'Title', 'Derau Impuls');
tab2b = uitab('Parent', tgroup2, 'Title', 'Derau Uniform');
tab2c = uitab('Parent', tgroup2, 'Title', 'Derau Gaussian');
tab2d = uitab('Parent', tgroup2, 'Title', 'Derau Rayleigh');

tab3a = uitab('Parent', tgroup3, 'Title', 'BandStop Ideal');
tab3b = uitab('Parent', tgroup3, 'Title', 'BandStop ButterWorth');
tab3c = uitab('Parent', tgroup3, 'Title', 'BandStop Gauss');

panel1 = uipanel('Parent',tab1a,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.1 .3 .35 .6]);

panel2 = uipanel('Parent',tab1a,'Title','Histogram','FontWeight','bold',...
    'FontSize',10,'Position',[.55 .3 .35 .6]);

ax1 = axes('Parent',panel1,'Position',[.065 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax2 = axes('Parent',panel2,'Position',[.14 .1 .8 .8],'XTick',[],...
    'YTick',[],'Visible','on');

I = imread('noisetest.bmp');
axes(ax1)
imshow(I)
axes(ax2)
imhist(I)

panel3 = uipanel('Parent',tab1b,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.1 .3 .35 .6]);

panel4 = uipanel('Parent',tab1b,'Title','Histogram','FontWeight','bold',...
    'FontSize',10,'Position',[.55 .3 .35 .6]);

ax3 = axes('Parent',panel3,'Position',[.065 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax4 = axes('Parent',panel4,'Position',[.14 .1 .8 .8],'XTick',[],...
    'YTick',[],'Visible','on');

g1 = imnoise(I,'salt & pepper',0.2);
axes(ax3)
imshow(g1)
axes(ax4)
imhist(g1)

panel5 = uipanel('Parent',tab1c,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.1 .3 .35 .6]);

panel6 = uipanel('Parent',tab1c,'Title','Histogram','FontWeight','bold',...
    'FontSize',10,'Position',[.55 .3 .35 .6]);

ax5 = axes('Parent',panel5,'Position',[.065 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax6 = axes('Parent',panel6,'Position',[.14 .1 .8 .8],'XTick',[],...
    'YTick',[],'Visible','on');

g2 = uint8(double(I)+60*rand(256,256));
axes(ax5)
imshow(g2)
axes(ax6)
imhist(g2)

panel7 = uipanel('Parent',tab1d,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.1 .3 .35 .6]);

panel8 = uipanel('Parent',tab1d,'Title','Histogram','FontWeight','bold',...
    'FontSize',10,'Position',[.55 .3 .35 .6]);

ax7 = axes('Parent',panel7,'Position',[.065 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax8 = axes('Parent',panel8,'Position',[.14 .1 .8 .8],'XTick',[],...
    'YTick',[],'Visible','on');

g3 = uint8(double(I)+10*randn(256,256));
axes(ax7)
imshow(g3)
axes(ax8)
imhist(g3)

panel9 = uipanel('Parent',tab1e,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.1 .3 .35 .6]);

panel10 = uipanel('Parent',tab1e,'Title','Histogram','FontWeight','bold',...
    'FontSize',10,'Position',[.55 .3 .35 .6]);

ax9 = axes('Parent',panel9,'Position',[.065 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax10 = axes('Parent',panel10,'Position',[.14 .1 .8 .8],'XTick',[],...
    'YTick',[],'Visible','on');

g4 = uint8(double(I)+raylrnd(20,256,256));
axes(ax9)
imshow(g4)
axes(ax10)
imhist(g4)

panel11 = uipanel('Parent',tab2a,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.05 .025 .3 .95]);

panel12 = uipanel('Parent',tab2a,'Title','Hasil Restorasi','FontWeight','bold',...
    'FontSize',10,'Position',[.4 .025 .55 .95]);

ax11 = axes('Parent',panel11,'Position',[.12 .53 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax12 = axes('Parent',panel11,'Position',[.12 .03 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax13 = axes('Parent',panel12,'Position',[.06 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax14 = axes('Parent',panel12,'Position',[.06 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax15 = axes('Parent',panel12,'Position',[.54 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax16 = axes('Parent',panel12,'Position',[.54 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax11)
imshow(I);
title('citra asli');

axes(ax12)
imshow(g1);
title('citra + derau Salt & pepper');

axes(ax13)
j1 = imfilter(g1,ones(3)/9);
imshow(j1);
title('filter rata-rata 3x3');

axes(ax14)
j2 = imfilter(g1,ones(5)/25);
imshow(j2);
title('filter rata-rata 5x5');

axes(ax15)
j3 = medfilt2(g1,[3 3]);
imshow(j3);
title('filter median 3x3');

axes(ax16)
j4 = medfilt2(g1,[5 5]);
imshow(j4);
title('filter median 5x5');

panel13 = uipanel('Parent',tab2b,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.05 .025 .3 .95]);

panel14 = uipanel('Parent',tab2b,'Title','Hasil Restorasi','FontWeight','bold',...
    'FontSize',10,'Position',[.4 .025 .55 .95]);

ax17 = axes('Parent',panel13,'Position',[.12 .53 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax18 = axes('Parent',panel13,'Position',[.12 .03 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax19 = axes('Parent',panel14,'Position',[.06 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax20 = axes('Parent',panel14,'Position',[.06 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax21 = axes('Parent',panel14,'Position',[.54 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax22 = axes('Parent',panel14,'Position',[.54 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax17)
imshow(I);
title('citra asli');

axes(ax18)
imshow(g2);
title('citra + derau Uniform');

axes(ax19)
j1 = imfilter(g2,ones(3)/9);
imshow(j1);
title('filter rata-rata 3x3');

axes(ax20)
j2 = imfilter(g2,ones(5)/25);
imshow(j2);
title('filter rata-rata 5x5');

axes(ax21)
j3 = medfilt2(g2,[3 3]);
imshow(j3);
title('filter median 3x3');

axes(ax22)
j4 = medfilt2(g2,[5 5]);
imshow(j4);
title('filter median 5x5');

panel15 = uipanel('Parent',tab2c,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.05 .025 .3 .95]);

panel16 = uipanel('Parent',tab2c,'Title','Hasil Restorasi','FontWeight','bold',...
    'FontSize',10,'Position',[.4 .025 .55 .95]);

ax23 = axes('Parent',panel15,'Position',[.12 .53 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax24 = axes('Parent',panel15,'Position',[.12 .03 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax25 = axes('Parent',panel16,'Position',[.06 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax26 = axes('Parent',panel16,'Position',[.06 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax27 = axes('Parent',panel16,'Position',[.54 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax28 = axes('Parent',panel16,'Position',[.54 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax23)
imshow(I);
title('citra asli');

axes(ax24)
imshow(g3);
title('citra + derau Gaussian');

axes(ax25)
j1 = imfilter(g3,ones(3)/9);
imshow(j1);
title('filter rata-rata 3x3');

axes(ax26)
j2 = imfilter(g3,ones(5)/25);
imshow(j2);
title('filter rata-rata 5x5');

axes(ax27)
j3 = medfilt2(g3,[3 3]);
imshow(j3);
title('filter median 3x3');

axes(ax28)
j4 = medfilt2(g3,[5 5]);
imshow(j4);
title('filter median 5x5');

panel17 = uipanel('Parent',tab2d,'Title','Noise Test','FontWeight','bold',...
    'FontSize',10,'Position',[.05 .025 .3 .95]);

panel18 = uipanel('Parent',tab2d,'Title','Hasil Restorasi','FontWeight','bold',...
    'FontSize',10,'Position',[.4 .025 .55 .95]);

ax29 = axes('Parent',panel17,'Position',[.12 .53 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax30 = axes('Parent',panel17,'Position',[.12 .03 .75 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax31 = axes('Parent',panel18,'Position',[.06 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax32 = axes('Parent',panel18,'Position',[.06 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax33 = axes('Parent',panel18,'Position',[.54 .53 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

ax34 = axes('Parent',panel18,'Position',[.54 .03 .4 .4],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax29)
imshow(I);
title('citra asli');

axes(ax30)
imshow(g4);
title('citra + derau Rayleigh');

axes(ax31)
j1 = imfilter(g4,ones(3)/9);
imshow(j1);
title('filter rata-rata 3x3');

axes(ax32)
j2 = imfilter(g4,ones(5)/25);
imshow(j2);
title('filter rata-rata 5x5');

axes(ax33)
j3 = medfilt2(g4,[3 3]);
imshow(j3);
title('filter median 3x3');

axes(ax34)
j4 = medfilt2(g4,[5 5]);
imshow(j4);
title('filter median 5x5');

%%%%
ax35 = axes('Parent',tab3a,'Position',[.165 .55 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax36 = axes('Parent',tab3a,'Position',[.55 .55 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax37 = axes('Parent',tab3a,'Position',[.16 .06 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax38 = axes('Parent',tab3a,'Position',[.55 .06 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

g=imread('cameramannoise.tif');
axes(ax35)
imshow(g);
title('citra + derau periodik');

G=fftshift(fft2(double(g)));
axes(ax36)
imagesc(abs(sqrt(G+eps)));
axis image,colormap(ax36,jet),colorbar,title('fft (citra + derau periodik)');
r=meshgrid(-128:127,-128:127);
r=sqrt(r.^2+r'.^2);
W=15;D=65;
Hideal=abs(r-D)>W/2;
Hbuttw=1./(1+((r*W)./(r.^2-D.^2+eps)).^(2*1));
Hgauss=1-exp(-0.5*abs(r.^2-D.^2)./(r*W+eps));
J1=G.*Hideal;j1=uint8(real(ifft2(fftshift(J1))));
J2=G.*Hbuttw;j2=uint8(real(ifft2(fftshift(J2))));
J3=G.*Hgauss;j3=uint8(real(ifft2(fftshift(J3))));
axes(ax37)
imagesc(abs(sqrt(J1)));
axis image,colormap(ax37,jet),colorbar,title('hasil restorasi (domain frekuensi)');
axes(ax38)
imshow(j1);
title('hasil restorasi (domain spasial)');

ax39 = axes('Parent',tab3b,'Position',[.165 .55 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax40 = axes('Parent',tab3b,'Position',[.55 .55 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax41 = axes('Parent',tab3b,'Position',[.16 .06 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax42 = axes('Parent',tab3b,'Position',[.55 .06 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax39)
imshow(g);
title('citra + derau periodik');

axes(ax40)
imagesc(abs(sqrt(G+eps)));
axis image,colormap(ax40,jet),colorbar,title('fft (citra + derau periodik)');

axes(ax41)
imagesc(abs(sqrt(J2)));
axis image,colormap(ax41,jet),colorbar,title('hasil restorasi (domain frekuensi)');

axes(ax42)
imshow(j2);
title('hasil restorasi (domain spasial)');

ax43 = axes('Parent',tab3c,'Position',[.165 .55 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax44 = axes('Parent',tab3c,'Position',[.55 .55 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax45 = axes('Parent',tab3c,'Position',[.16 .06 .32 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax46 = axes('Parent',tab3c,'Position',[.55 .06 .22 .38],'XTick',[],...
    'YTick',[],'Visible','on');

axes(ax43)
imshow(g);
title('citra + derau periodik');

axes(ax44)
imagesc(abs(sqrt(G+eps)));
axis image,colormap(ax44,jet),colorbar,title('fft (citra + derau periodik)');

axes(ax45)
imagesc(abs(sqrt(J3)));
axis image,colormap(ax45,jet),colorbar,title('hasil restorasi (domain frekuensi)');

axes(ax46)
imshow(j3);
title('hasil restorasi (domain spasial)');

panel15 = uipanel('Parent',tab4,'Title','Citra Asli','FontWeight','bold',...
    'FontSize',10,'Position',[.02 .25 .3 .5]);

panel16 = uipanel('Parent',tab4,'Title','Citra Terdistorsi','FontWeight','bold',...
    'FontSize',10,'Position',[.35 .25 .3 .5]);

panel17 = uipanel('Parent',tab4,'Title','Hasil Restorasi','FontWeight','bold',...
    'FontSize',10,'Position',[.68 .25 .3 .5]);

ax47 = axes('Parent',panel15,'Position',[.07 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax48 = axes('Parent',panel16,'Position',[.07 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

ax49 = axes('Parent',panel17,'Position',[.07 .08 .85 .85],'XTick',[],...
    'YTick',[],'Visible','on');

f = double(imread('bicycle.tif'));
axes(ax47)
imagesc(uint8(f));
axis off,colormap gray;

h = fspecial('motion',10,150);
g = imfilter(f,h,'circular','conv');
axes(ax48)
imagesc(uint8(g));
axis off,colormap gray;

G = fft2(g,256,256);
H = fft2(h,256,256);
J = G./H;
epsilon = 1e-6; J(abs(H)<epsilon)=0;
j = real(ifft2(J));
j = circshift(j,[floor(size(h,1)/2) floor(size(h,2)/2)]);
axes(ax49)
imagesc(uint8(j));
axis off,colormap gray;

ax50 = axes('Parent',tab5,'Position',[.18 .55 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax51 = axes('Parent',tab5,'Position',[.55 .55 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax52 = axes('Parent',tab5,'Position',[.18 .06 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax53 = axes('Parent',tab5,'Position',[.55 .06 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

f = double(imread('bicycle.tif'));
axes(ax50)
imagesc(uint8(f));
axis off,colormap gray,title('citra asli');

h = fspecial('motion',10,150);
g = imfilter(f,h,'circular','conv');
g = g + 0.1*randn(size(g));
axes(ax51)
imagesc(uint8(g));
axis off,colormap gray,title('citra terdistorsi + derau');

G = fft2(g,256,256);
H = fft2(h,256,256);
J = G./H;
epsilon = 1e-6; J(abs(H)<epsilon)=0;
j = real(ifft2(J));
j = circshift(j,[floor(size(h,1)/2) floor(size(h,2)/2)]);
axes(ax52)
imagesc(uint8(j));
axis off,colormap gray,title('citra restorasi inverse filter');

gamma = 1e-3;
K = (G./H).*(abs(H).^2./(abs(H).^2+gamma));
k = real(ifft2(K));
k = circshift(k,[floor(size(h,1)/2) floor(size(h,2)/2)]);
axes(ax53)
imagesc(uint8(k));
axis off,colormap gray,title('citra restorasi pseudo-inverse');

ax54 = axes('Parent',tab6,'Position',[.18 .55 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax55 = axes('Parent',tab6,'Position',[.55 .55 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax56 = axes('Parent',tab6,'Position',[.18 .06 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

ax57 = axes('Parent',tab6,'Position',[.55 .06 .25 .38],'XTick',[],...
    'YTick',[],'Visible','on');

I = im2double(imread('cameraman.tif'));
axes(ax54)
imagesc(I), axis off;
title('Original Image')

LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
axes(ax55)
imagesc(blurred_noisy), axis off;
title('Simulate Blur and Noise')

estimated_nsr = 0;
wnr2 = deconvwnr(blurred_noisy, PSF, estimated_nsr);
axes(ax56)
imagesc(wnr2), axis off;
title('Restoration Using NSR = 0')

estimated_nsr = noise_var / var(I(:));
wnr3 = deconvwnr(blurred_noisy, PSF, estimated_nsr);
axes(ax57)
imagesc(wnr3), axis off;
title('Restoration Using Estimated NSR');
