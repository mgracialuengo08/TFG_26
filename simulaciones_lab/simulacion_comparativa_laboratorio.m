clear; clc; close all;
%% 1. CARGAR DATOS
datos_lab_sin = readmatrix('parche_short_sin_bola.s1p', 'FileType', 'text', 'CommentStyle', '#'); 
datos_lab_con = readmatrix('parche_short_con_bola.s1p', 'FileType', 'text', 'CommentStyle', '#');
% Separamos los ejes para el laboratorio (sin bola)
freq_lab_sin = datos_lab_sin(:, 1) / 1e9;
s11_lab_sin  = datos_lab_sin(:, 2);
% Separamos los ejes para el laboratorio (con bola)
freq_lab_con = datos_lab_con(:, 1) / 1e9;
s11_lab_con  = datos_lab_con(:, 2);

%% 2. CREAR LA GRÁFICA
figure('Color', [1 1 1]);
% Laboratorio sin bola (azul)
plot(freq_lab_sin, s11_lab_sin, 'Color', [0 0.4470 0.7410], 'LineWidth', 2, 'LineStyle', '-');
hold on;
% Laboratorio con bola (rojo)
plot(freq_lab_con, s11_lab_con, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'LineStyle', '--');
grid on;
set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.4);

% Títulos de los ejes
xlabel('Frecuencia (GHz)', 'FontSize', 11, 'FontName', 'Arial');
ylabel('S_{11} (dB)', 'FontSize', 11, 'FontName', 'Arial');
xlim([4.5 6.5]); % Rango de 4.5 a 6.5 GHz 
ylim([-60 0]); % dB

%% 3. BÚSQUEDA AUTOMÁTICA Y ANOTACIÓN DE LOS PUNTOS MÍNIMOS
% Encontrar mínimos de Laboratorio (sin bola)
[min_s11_sin, idx_sin] = min(s11_lab_sin);
f_min_sin = freq_lab_sin(idx_sin);

% Encontrar mínimos de Laboratorio (con bola)
[min_s11_con, idx_con] = min(s11_lab_con);
f_min_con = freq_lab_con(idx_con);

% Extraemos los límites
limites_x = xlim;
limites_y = ylim;

% Dibujar líneas indicadoras para Laboratorio sin bola (azul)
plot([f_min_sin, f_min_sin], [limites_y(1), min_s11_sin], ':', 'Color', [0 0.4470 0.7410], 'LineWidth', 1);
plot([limites_x(1), f_min_sin], [min_s11_sin, min_s11_sin], ':', 'Color', [0 0.4470 0.7410], 'LineWidth', 1);
plot(f_min_sin, min_s11_sin, 'o', 'MarkerFaceColor', [0 0.4470 0.7410], 'MarkerEdgeColor', 'k');

% Dibujar líneas indicadoras para Laboratorio con bola (naranja)
plot([f_min_con, f_min_con], [limites_y(1), min_s11_con], ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
plot([limites_x(1), f_min_con], [min_s11_con, min_s11_con], ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
plot(f_min_con, min_s11_con, 's', 'MarkerFaceColor', [0.8500 0.3250 0.0980], 'MarkerEdgeColor', 'k');

% Añadir etiquetas de texto flotantes con los valores reales
text(f_min_sin + 0.05, min_s11_sin - 2, sprintf('Sin bola: %.2f GHz, %.1f dB', f_min_sin, min_s11_sin), 'Color', [0 0.4470 0.7410], 'FontSize', 9, 'FontName', 'Arial');
text(f_min_con + 0.05, min_s11_con + 2, sprintf('Con bola: %.2f GHz, %.1f dB', f_min_con, min_s11_con), 'Color', [0.8500 0.3250 0.0980], 'FontSize', 9, 'FontName', 'Arial');

% Leyenda 
legend({'Laboratorio (sin bola)', 'Laboratorio (con bola)'}, 'Location', 'SouthWest', 'FontSize', 10, 'FontName', 'Arial');