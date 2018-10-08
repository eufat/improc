gambar=imread('kucing.jpg');
gaussianFilter=fspecial('gaussian', [10, 10], 5);
hasil=imfilter(gambar, gaussianFilter, 'symmetric', 'conv');
subplot(1,2,1), image(gambar);
subplot(1,2,2), image(hasil);