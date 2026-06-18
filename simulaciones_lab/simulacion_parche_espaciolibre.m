clear; clc; close all;
%% 1. CARGAR DATOS
datos_cst = readmatrix('S11_parche_fr4.txt', 'FileType', 'text', 'CommentStyle', '#'); 
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

%% 3. BÚSQUEDA AUTOMÁTICA Y ANOTACIÓN DE LOS PUNTOS MÍNIMOS
% Encontrar mínimos de CST
[min_s11_cst, idx_cst] = min(s11_cst);
f_min_cst = freq_cst(idx_cst);

% Encontrar mínimos del Laboratorio
[min_s11_lab, idx_lab] = min(s11_lab);
f_min_lab = freq_lab(idx_lab);

% Extraemos los límites
limites_x = xlim;
limites_y = ylim;

% Dibujar líneas indicadoras para CST (azul)
plot([f_min_cst, f_min_cst], [limites_y(1), min_s11_cst], ':', 'Color', [0 0.4470 0.7410], 'LineWidth', 1);
plot([limites_x(1), f_min_cst], [min_s11_cst, min_s11_cst], ':', 'Color', [0 0.4470 0.7410], 'LineWidth', 1);
plot(f_min_cst, min_s11_cst, 'o', 'MarkerFaceColor', [0 0.4470 0.7410], 'MarkerEdgeColor', 'k');

% Dibujar líneas indicadoras para Laboratorio (naranja)
plot([f_min_lab, f_min_lab], [limites_y(1), min_s11_lab], ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
plot([limites_x(1), f_min_lab], [min_s11_lab, min_s11_lab], ':', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1);
plot(f_min_lab, min_s11_lab, 's', 'MarkerFaceColor', [0.8500 0.3250 0.0980], 'MarkerEdgeColor', 'k');

% Añadir etiquetas de texto flotantes con los valores reales
text(f_min_cst + 0.05, min_s11_cst - 2, sprintf('CST: %.2f GHz, %.1f dB', f_min_cst, min_s11_cst), 'Color', [0 0.4470 0.7410], 'FontSize', 9, 'FontName', 'Arial');
text(f_min_lab + 0.05, min_s11_lab + 2, sprintf('Lab: %.2f GHz, %.1f dB', f_min_lab, min_s11_lab), 'Color', [0.8500 0.3250 0.0980], 'FontSize', 9, 'FontName', 'Arial');

% Leyenda 
legend({'CST', 'Laboratorio'}, 'Location', 'SouthWest', 'FontSize', 10, 'FontName', 'Arial');