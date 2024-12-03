%% 3. Planos
%Carga de la imagen
clear all; close all; clc;
a= imread('tue00.jpg');

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
a_recorte = a(1396:1801 ,  975:1437, :);
figure (1), subplot(3,3,7), image(a_recorte), title('Imagen recortada');

% Perfil de linea - variación de niveles de gris 

pl = ag(1621, :);  
figure(1), subplot(3,3,8), plot(pl), title('Grafica, perfil de linea');
ag(1621, :)= 0;  %muestra la linea en esa fila 
figure (1), subplot(3,3,9),imshow(ag), title('Linea en esa fila');
% 
%% 5. Byte más significativo - resolución radiométrica
% arb7 = bitand(ar,128)*2;% comparación entre el plano y el byte correspondiente 128
% arb6 = bitand(ar,64)*4; 
% arb5 = bitand(ar,32)*8; 
% arb4 = bitand(ar,16)*16; 
% arb3 = bitand(ar,8)*32; 
% arb2 = bitand(ar,4)*64; 
% arb1 = bitand(ar,2)*128; 
% arb0 = bitand(ar,1)*256; 
% 
% figure(2), subplot(3,3,1), imshow(ar)
% figure(2), subplot(3,3,2), imshow(arb7)
% figure(2), subplot(3,3,3), imshow(arb6)
% figure(2), subplot(3,3,4), imshow(arb5)
% figure(2), subplot(3,3,5), imshow(arb4)
% figure(2), subplot(3,3,6), imshow(arb3)
% figure(2), subplot(3,3,7), imshow(arb2)
% figure(2), subplot(3,3,8), imshow(arb1)
% figure(2), subplot(3,3,9), imshow(arb0)
% 
% arb7 = bitand(ar,128);  % sin compenzar
% arb6 = bitand(ar,64); 
% arb5 = bitand(ar,32); 
% arb4 = bitand(ar,16); 
% arb3 = bitand(ar,8); 
% arb2 = bitand(ar,4); 
% arb1 = bitand(ar,2); 
% arb0 = bitand(ar,1); 
% 
%  %Creamos un nuevo plano // tambien podemos eliminar:
%  arnuevo= arb7 + arb6 + arb5 + arb4 + arb3 + arb2 + arb1 + arb0;
% 
%  figure(3), subplot (2,1,1), imshow(ar)
%  figure(3), subplot (2,1,2), imshow(arnuevo)



%% Conversión RGB a HSV 
% conv = rgb2hsv(a);
% % H = conv(:,:,1);
% % S = conv(:,:,2);
% % V = conv(:,:,3);
% 
% %Estamos en el intervalo cerrado 0 y 1, cambiamos de 0 a 255
% 
% % H=(255.0).*H;
% % S=(255.0).*S;
% % V=(255.0).*V;
% % 
% % %Para que solo sean numeros enteros
% % 
% % H = uint8(H);
% % S = uint8(S);
% % V = uint8(V);
% 
% % max(max(a)); el max de la imagen 255
% %min(min(a));  el min de la imagen 0
% 
% imshow(conv)
% %imshow(a);
% % imshow(a, [0, 255]);
% % imshow([H,S,V]);
% 
% % Si queremos ver cada uno de los planos de la imagen 
% imshow(conv, [0,1])
% imshow([conv(:,:,1), conv(:,:,2), conv(:,:,3)]);

%% Conversión RGB a YCBCR
% 
% YCBCR = rgb2ycbcr(a);
% figure (1), subplot(3,3,7), imshow(YCBCR), title('Plano YCBCR');
% 
% % Convert RGB to XYZ
% 
% XYZ = rgb2xyz(a);
% figure (1), subplot(3,3,8), imshow(XYZ), title('Plano YCBCR');


