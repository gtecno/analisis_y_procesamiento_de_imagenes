%% 9. Convolución 2D 
clear all; close all; clc;

% Carga de la imagen
a= imread('tue00.jpg');
% a= imread('Rostros.jpg');

% Extracción de los planos
ag = double(a(:,:,2));
s = size(a);
agc = ag*0;  %reserva de memoria

% Convolucion 
kernel = [1 1 1; 1 1 1; 1 1 1]/9;   % filtro de promedio- eliminando frecuencias altas
kernelgauss = [1 2 1; 2 4 2; 1 2 1]/16;  % filtro gaussiano

for i= 2:s(1)-1
    for j= 2:s(2)-1
        ventana = ag(i-1:i+1, j-1:j+1);
        prod = ventana .* kernel;
        pix = sum(sum(prod));   %f[x,y]*g[x,y]
        agc(i,j) = pix;
    end
end

% Despliegue
figure(1),  imshow(uint8(ag)), title('Imagen Original')
figure(2), imshow(uint8(agc)), title('Imagen Conv')

%filtro altas frecuencias
altasf = ag-agc;
figure(3), imshow(uint8(altasf))