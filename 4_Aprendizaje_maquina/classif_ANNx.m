%% 
% Script para CLASIFICACION CON REDES NEURONALES ARTIFICIALES
% Electiva: Procesamiento Digital de Imágenes
% 
%% Limpiar el espacio de trabajo
close all;
clc;
clear all;
%% Configuración inicial
% addpath('###');

%% Leer datos, descriptores
matr_descrip = xlsread('Caracteristicas_y_Reconocimiento_de_Patrones_Training_set.xlsx'); %Contiene descriptores en la tabla, xlsread carga sólo los valores numéricos de la primera pestaña
ss = size(matr_descrip); %tamaño de la matriz, en este caso de 30x6

for i = 1:ss(1) %Cada 5 posiciones del vector se toman las 3 primeras muestras de cada clase (con esto se dejan 2 para la prueba)
    area(i) = matr_descrip(i,1);  
    perim(i) = matr_descrip(i,2);
    orien(i) = matr_descrip(i,3);
    circ(i) = matr_descrip(i,4);
    ejeMen(i) = matr_descrip(i,5);
    ejeMay(i) = matr_descrip(i,6);
end

%% Configuración y ejecución del clasificador
% 1.1 Configuración input
X = [area; perim; orien; circ; ejeMen; ejeMay]'; %Datos de entrenamiento
%X = [area; circ]'; %Datos de entrenamiento

% 1.2 Configuración target
T = repmat([1 2 3 4 5 6 7 8 9 10],5,1); %Se crea una matriz con las etiquetas posibles para las muestras (2 filas, 1 columna)
target = T(:); %Se serializa T, Vector objetivo para la clasif supervisada
%target = target';

%% 2: Configuración de la red neuronal
disp('Configuring Neural Network...');
trainFcn = 'trainlm';                              % Levenberg-Marquardt
hiddenLayerSize = [3 15 5];                        %if I need more layers then I should write: [10,12,...,9]
net = fitnet(hiddenLayerSize,trainFcn);
% net.layers{1}.transferFcn='logsig';                %tansig by default, but I can put another
% net.layers{2}.transferFcn='tansig';   
% net.layers{3}.transferFcn='purelin';  
% net.trainParam.goal = 0.1;
% net.trainParam.epochs = 500;
%net = init(net);                                  %initializing the network with previous configurations
% view(net)                                          % para visualizar la red final 
[net, tr] = train(net,X',target');               %training

%% Validación del modelo sobre muestras de prueba (las que no se usaron durante el entrenamiento)
matr_descrip_test = xlsread('Caracteristicas_y_Reconocimiento_de_Patrones_Test_set.xlsx'); %Contiene descriptores en la tabla, xlsread carga sólo los valores numéricos de la primera pestaña
ss_test = size(matr_descrip_test); %tamaño de la matriz, en este caso de 30x6

for j = 1:ss_test(1) %Cada 5 posiciones del vector se toman las 3 primeras muestras de cada clase (con esto se dejan 2 para la prueba)
    area_test(j) = matr_descrip_test(j,1);
    perim_test(j) = matr_descrip_test(j,2);
    orien_test(j) = matr_descrip_test(j,3);
    circ_test(j) = matr_descrip_test(j,4);
    ejeMen_test(j) = matr_descrip_test(j,5);
    ejeMay_test(j) = matr_descrip_test(j,6);
end
X_v = [area_test; perim_test; orien_test; circ_test; ejeMen_test; ejeMay_test]'; %Datos de entrenamiento %Datos de prueba
%X_v = [area; circ]';


%Respuesta del clasificador
outputs = round(net(X_v'));
outputs % para presentar en pantalla un vector fila con los resultados (como responde)
%target'; %... y compararlo con el objetivo (como debería responder)
T_test = repmat([1 2 3 4 5 6 7 8 9 10],3,1); 
target_test = T_test(:);
target_test' %... y compararlo con el objetivo (como debería responder)
% Evaluación del desempeño: Es mejor si se acerca a 100
%performance = perform(net, target', outputs)
eval = sum(outputs==target_test')/length(target_test)*100; 
disp(eval);

%save ANN_model86 net % guardar modelo clasificador