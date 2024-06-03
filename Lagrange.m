% Datos
semanas = [1, 2, 3, 4, 5, 6, 7];
pesos = [0.017, 0.040, 0.065, 0.085, 0.150, 0.180, 0.250];

% Función para calcular el polinomio de Lagrange
function P = lagrange_interpol(t, semanas, pesos)
    n = length(semanas);
    P = 0;
    for k = 1:n
        Lk = 1;
        for i = 1:n
            if i ~= k
                Lk = Lk * (t - semanas(i)) / (semanas(k) - semanas(i));
            end
        end
        P = P + pesos(k) * Lk;
    end
end

% Generar resultados para puntos originales y puntos intermedios
resultados = [];
for t = [semanas, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5]
    peso_interp = lagrange_interpol(t, semanas, pesos);
    if ismember(t, semanas)
        peso_original = pesos(semanas == t);
    else
        peso_original = NaN;
    end
    resultados = [resultados; t, peso_original, peso_interp];
end

% Mostrar resultados en tabla
fprintf('Semana (t) | Peso Original (g) | Peso Interpolado (g)\n');
fprintf('-----------------------------------------------\n');
for i = 1:size(resultados, 1)
    if isnan(resultados(i, 2))
        fprintf('  %.1f      |       -       |        %.4f\n', resultados(i, 1), resultados(i, 3));
    else
        fprintf('  %.1f      |    %.4f      |        %.4f\n', resultados(i, 1), resultados(i, 2), resultados(i, 3));
    end
end

% Visualización
t_vals = linspace(min(semanas), max(semanas), 100);
p_vals = arrayfun(@(t) lagrange_interpol(t, semanas, pesos), t_vals);

figure;
plot(t_vals, p_vals, 'b-', 'DisplayName', 'Polinomio de Lagrange');
hold on;
plot(semanas, pesos, 'ro', 'DisplayName', 'Datos de peso de los peces');
xlabel('Semana');
ylabel('Peso de los peces (g)');
title('Interpolación de Lagrange para el peso de los peces');
legend show;
grid on;
hold off;
