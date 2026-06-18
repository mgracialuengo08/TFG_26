clear; clc; close all;

%% 1. CARGAR DATOS
datos_lab_sin = readmatrix('parche_short_sin_bola.s1p', 'FileType', 'text', 'CommentStyle', '#'); 
datos_lab_con = readmatrix('parche_short_con_bola.s1p', 'FileType', 'text', 'CommentStyle', '#');

% Separamos los ejes para la simulación
freq_lab_sin = datos_lab_sin(:, 1) / 1e9;
s11_lab_sin  = datos_lab_sin(:, 2);

% Separamos los ejes para la medida real
freq_lab_con = datos_lab_con(:, 1)/ 1e9;
s11_lab_con = datos_lab_con(:, 2);


%% 2. CREAR LA GRÁFICA
figure('Color', [1 1 1]);

% Simulación con CST (azul)
plot(freq_lab_sin, s11_lab_sin, 'Color', [0 0.4470 0.7410], 'LineWidth', 2, 'LineStyle', '-');
hold on;

% Simulación en laboratorio (rojo)
plot(freq_lab_con, s11_lab_con, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'LineStyle', '--');

grid on;
set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.4);

% Títulos de los ejes
xlabel('Frecuencia (GHz)', 'FontSize', 11, 'FontName', 'Arial');
ylabel('S_{11} (dB)', 'FontSize', 11, 'FontName', 'Arial');
xlim([4.5 6.5]); % Rango de 4.5 a 6.5 GHz 
ylim([-60 0]); % dB

% Leyenda 
legend({'Laboratorio (sin bola)', 'Laboratorio (con bola)'}, 'Location', 'SouthWest', 'FontSize', 10, 'FontName', 'Arial');
