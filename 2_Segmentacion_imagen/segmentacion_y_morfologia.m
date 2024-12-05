    %% Segmentación
    %Electiva: Procesamiento de imágenes
    %% Limpiando el espacio de trabajo
    close all;
    clc;
    clear all;
    %% Lectura de imagen RGB y transformación a escala de gris.
    %Imagen en RGB
    
    imageArrays = ["tue00.jpg","tue09.jpg","tue14.jpg","tue24.jpg","tue34.jpg","tue35.jpg"];
    n = numel(imageArrays);
    
    for i=1:n
        imagenRGB = imread(imageArrays(i));
        greenChannel = imagenRGB(:, :, 2);
        I = imhist(greenChannel); %Histograma
        level = 125 / 256;
        binaryImg = uint8(~imbinarize(greenChannel, level)) * 255;
    
    
        %Mostrar imagen
        figure(i), subplot(2,2,1), imshow(imagenRGB), title('Imagen original RGB')
        figure(i), subplot(2,2,2), imshow(greenChannel), title('Imagen en el canal Verde')
        figure(i), subplot(2,2,3), plot(I), title('histograma')
        figure(i), subplot(2,2,4), imshow(binaryImg), title('Segmento con Umbral Manual')
    
        %% morfológia Matemática
        se1 = strel('square', 5);    %Cuadrado de lado 5
        se2 = strel('line', 10, 30); %Linea de  long 10 y ángulo 30
        se3 = strel('disk', 15);     %Disco de radio 15
        se4 = strel('ball', 15, 5);  %Circulo/bola de radio 15 y alto 5
        seArray = [se1,se2,se3,se4];
    
        if(i == 1)
    
            %morfológia Matemática
            for j=1:4
                D = imdilate(binaryImg,seArray(j)); %Dilatación
                E = imerode(binaryImg, seArray(j) );  %Erosión
                A = imopen(binaryImg,  seArray(j));   %Apertura
                C = imclose(binaryImg, seArray(j));  %Cierre
    
                figure(6+j), subplot(2,2,1), imshow(D),title('Dilatación')
                figure(6+j), subplot(2,2,2), imshow(E),title('Erosión')
                figure(6+j), subplot(2,2,3), imshow(A),title('Apertura')
                figure(6+j), subplot(2,2,4), imshow(C),title('Cierre')
    
                %rellenado de huecos
                if(j == 2)
                    binh_fill = imfill(C, 'holes');
                    figure(11), imshow(binh_fill), title('Llenado de huecos plano morfológico Line')
    
    
                    %% Esqueletización y conteo de puntas
                    BW_esquel = bwmorph(C,'skel',Inf);
                    figure(12), imshow(BW_esquel), title('Esqueletización')
    
    
                    %% Conteo de puntas
                    BW_puntas = bwmorph(BW_esquel,'endpoints',Inf);
                    num_puntas = size(find(BW_puntas>0),1);
                end
            end
        end
    
    
    
    
        %% morfológia Matemática Tuercas
        if(i == 4)
    
            %morfológia Matemática Tuercas
            for f=1:4
                DT = imdilate(binaryImg,seArray(f)); %Dilatación
                ET = imerode(binaryImg, seArray(f) );  %Erosión
                AT = imopen(binaryImg,  seArray(f));   %Apertura
                CT = imclose(binaryImg, seArray(f));  %Cierre
    
                figure(12+f), subplot(2,2,1), imshow(DT),title('Dilatación')
                figure(12+f), subplot(2,2,2), imshow(ET),title('Erosión')
                figure(12+f), subplot(2,2,3), imshow(AT),title('Apertura')
                figure(12+f), subplot(2,2,4), imshow(CT),title('Cierre')
    
                %rellenado de huecos LINEA
                if(f == 2)
                    binh_fillT = imfill(ET, 'holes');
                    figure(19), imshow(binh_fillT), title('Llenado de huecos plano morfológico Line')
    
    
                    %% Esqueletización y conteo de puntas
                    BW_esquelT = bwmorph(ET,'skel',Inf);
                    figure(20), imshow(BW_esquelT), title('Esqueletización')
    
    
                    %% Conteo de puntas
                    BW_puntasT = bwmorph(BW_esquelT,'endpoints',Inf);
                    num_puntasT = size(find(BW_puntasT>0),1);
                end
            end
        end
    
    end
