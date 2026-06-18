clear; clc; close all;

%% 1. CARGAR DATOS
datos_cst = readmatrix('S11_parche.txt', 'FileType', 'text', 'CommentStyle', '#'); 
datos_lab = readmatrix('parche_short_sin_bola.s1p', 'FileType', 'text', 'CommentStyle', '#');

% Separamos los ejes para la simulación
freq_cst = datos_cst(:, 1);
s11_cst  = datos_cst(:, 2);

% Separamos los ejes para la medida en laboratorio
freq_lab = datos_lab(:, 1)/ 1e9;
s11_lab  = datos_lab(:, 2);


%% 2. CREAR LA GRÁFICA
figure('Color', [1 1 1]);

% Simulación con CST (azul)
plot(freq_cst, s11_cst, 'Color', [0 0.4470 0.7410], 'LineWidth', 2, 'LineStyle', '-');
hold on;

% Medida en laboratorio (rojo)
plot(freq_lab, s11_lab, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'LineStyle', '--');

grid on;
set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.4);

% Títulos de los ejes
xlabel('Frecuencia (GHz)', 'FontSize', 11, 'FontName', 'Arial');
ylabel('S_{11} (dB)', 'FontSize', 11, 'FontName', 'Arial');
xlim([4.5 6.5]); % Rango de 4.5 a 6.5 GHz 
ylim([-60 0]); % dB

% Leyenda 
legend({'Simulación CST', 'Laboratorio'}, 'Location', 'SouthWest', 'FontSize', 10, 'FontName', 'Arial');