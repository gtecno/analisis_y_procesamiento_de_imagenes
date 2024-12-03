%% 6. Procesamiento de punto
%Carga de imagen 
clear all; close all; clc;
a= imread('tue00.jpg');


b1= a+100;   % Si le subimos más al número se ve como se pierde los niveles de gris
b2= b1-100;
b3= a-100;   %Se oscurece la imagen 
b4=a*1.5;    %Aumenta el valor de pendiente
b5=a/1.5;    %Diminuye el valor de pendiente
%b6=a.^1.5;   %El contenedor no es suficiente

figure (1), subplot(3,3,2),imshow(a), title('imagen original');
figure (1), subplot(3,3,4),imshow(b1), title('(img + 100)');
figure (1), subplot(3,3,5),imshow(b2), title('((img + 100) - 100)');
figure (1), subplot(3,3,6),imshow(b3), title('(img - 100)');
figure (1), subplot(3,3,7),imshow(b4), title('(img * 1.5)');
figure (1), subplot(3,3,8),imshow(b5), title('(img / 1.5)');
%figure (1), subplot(3,3,9),imshow(b6), title('imagen procesada (img ^ 1.5)');

%% Operaciones punto - normalización
a= imread('tue00.jpg');
ag= a(:,:,2);
figure (1), subplot(2,2,1),imshow(ag), title('Imagen original');

% ANTES
% Valores de punto flotante
% Valores normalizados
ag=double(ag);
ag = ag/255; 

% Procesamiento
bg = ag.^0.6;  % El valor debe estar normalizado

% DESPUÉS 
% Desnormailización
% Valores de enteros de 8 bits sin signo - uint8
bg= bg*255;
bg= uint8(bg);
ag= ag*255;
ag= uint8(ag);
figure (2), subplot(2,2,1),imshow(bg), title('Imagen procesado');

s=size(a);
histag = zeros(1,256);  % un vector fila
histbg = zeros(1,256);

for f = 1:s(1)      %recorremos las filas 
     for c = 1:s(2) %recorremos las columnas 
         ng=ag(f,c);
         histag(ng+1) =  histag(ng+1)+1;
         ng=bg(f,c);
         histbg(ng+1) =  histbg(ng+1)+1;
     end
end
figure (1), subplot(2,2,3),plot(histag), title('Histograma Imagen Original');
figure (2), subplot(2,2,3),plot(histbg), title('Histograma Imagen Procesado');