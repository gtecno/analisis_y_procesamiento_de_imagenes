%% 3. Planos
%Carga de la imagen
clear all; close all; clc;
a= imread('tue35.jpg');

colormap(jet)
% Extracción de los planos
 
ar = a(:,:,1);
ag = a(:,:,2);
ab = a(:,:,3);

% Despliegue
figure (1), subplot(3,3,2),imshow(a), title('Plano original');
figure (1), subplot(3,3,4),imshow(ar), title('Plano rojo');
figure (1), subplot(3,3,5),imshow(ag), title('Plano verde');
figure (1), subplot(3,3,6),imshow(ab), title('Plano azul');

%% 4. Recortar imagen
% 
% útilizar imshow en vez de image para poder visualizar los canales.
% EN caso se dese recortar un solo canal se debe cambiar ":" por el canal
% de 1-3
a_recorte = a(1350:2000 ,  354:1500, :);
figure (1), subplot(3,3,7), image(a_recorte), title('Imagen recortada');

% Perfil de linea - variación de niveles de gris 

pl = ag(1581, :);  
figure(1), subplot(3,3,8), plot(pl), title('Grafica, perfil de linea');
ag(1581, :)= 0;  %muestra la linea en esa fila 
figure (1), subplot(3,3,9),imshow(ag), title('Linea en esa fila');
figure (2),imshow(ag), title('Linea en esa fila');