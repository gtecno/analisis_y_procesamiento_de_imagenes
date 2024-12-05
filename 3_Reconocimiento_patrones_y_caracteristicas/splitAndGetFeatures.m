%% Limpiando el espacio de trabajo
close all;
clc;
clear all; 
%% Recortar Imagenes
% Ruta del directorio con las imágenes
imageDir = '/MATLAB Drive/3_Reconocimiento_patrones_y_caracteristicas/ElementosFerreteria/entrenamiento';
%imageDir = '/MATLAB Drive/3_Reconocimiento_patrones_y_caracteristicas/ElementosFerreteria/prueba';

% Obtener la lista de imágenes
imageFiles = dir(fullfile(imageDir, '*.jpg'));

% Inicializar celda para guardar características y nombres
numImages = length(imageFiles);
features = cell(numImages, 8); % 8 columnas para las características
headers = {'Nombre','Label','Area', 'Perimetro', 'Orientacion', ...
           'Circularidad', 'EjeMayor', 'EjeMenor'};

for k = 1:numImages
    % Leer la imagen
    img = imread(fullfile(imageDir, imageFiles(k).name));
    
    % Extraer el canal verde
    greenChannel = img(:, :, 2);

    % Binarizar la imagen para segmentar el objeto
    level = 125 / 256; % Umbral manual
    binaryImage = uint8(~imbinarize(greenChannel, level)) * 255;

    % Limpiar ruido usando operaciones morfológicas
    binaryClean = imopen(binaryImage,strel('line', 10, 30));
    binaryClean = imclose(binaryClean,strel('line', 10, 30));

    % Etiquetar objetos conectados
    labeledImage = bwlabel(binaryClean);
    stats = regionprops(labeledImage, 'BoundingBox', 'Area', 'Perimeter','Orientation', 'Circularity', 'MajorAxisLength', 'MinorAxisLength');
    
    % Seleccionar el objeto con el área más grande
    if ~isempty(stats)
        [~, largestIdx] = max([stats.Area]); % Índice del objeto principal
        boundingBox = stats(largestIdx).BoundingBox; 

        % Recortar la imagen usando el bounding box (si es necesario)
        %croppedImage = imcrop(img, boundingBox);

        % Guardar las características en la celda
        image_name = imageFiles(k).name;
        features{k, 1} = image_name; % Nombre de la imagen
        features{k, 2} = image_name(1:5); % Label de la imagen
        features{k, 3} = stats(largestIdx).Area; % Área
        features{k, 4} = stats(largestIdx).Perimeter; % Perímetro
        features{k, 5} = stats(largestIdx).Orientation; % Orientación
        features{k, 6} = stats(largestIdx).Circularity; % Circularidad
        features{k, 7} = stats(largestIdx).MajorAxisLength; % Longitud del eje mayor
        features{k, 8} = stats(largestIdx).MinorAxisLength; % Longitud del eje menor
    end
end

% Convertir las características en una tabla
result_table = cell2table(features, 'VariableNames', headers);

% Guardar la tabla en un archivo Excel
excelFilename = 'Caracteristicas_y_Reconocimiento_de_Patrones_Training_set.xlsx';
%excelFilename = 'Caracteristicas_y_Reconocimiento_de_Patrones_Test_set.xlsx';
writetable(result_table, excelFilename);

disp(['Archivo Excel generado: ', excelFilename]);


