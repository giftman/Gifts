f=imread('ImageEncrypted.tif');
imshow(f);
h=imhist(f);
plot(h)
axis([0 255 0 700])
set(gca,'xtick',[0:50:255])
set(gca,'ytick',[0:100:700])
