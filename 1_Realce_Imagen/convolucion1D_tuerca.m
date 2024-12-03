%% 8. Convolución 1D
clc; clear all;

% Carga de la imagen
a= imread('tue00.jpg');

% Extracción de los planos
ag = a(:,:,2);

% Perfil de línea
lin=175;
pl = ag(lin,:);
ag(lin,:) = 0;


% Convolucion 
k = [1 1 1 1 1];    % funcion g - conocida
c = conv(pl,k);     % funcion f - desconocida

% Despliege
figure(1), subplot(3,1,1), image(ag), title('Imagen Original'), colormap gray(256)
figure(1), subplot(3,1,2), plot(pl), title('Perfil de línea')
figure(1), subplot(3,1,3), plot(c), title('Perfil de línea convolución')