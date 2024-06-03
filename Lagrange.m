% Datos
semanas = [1, 2, 3, 4, 5, 6, 7];
pesos = [0.017, 0.040, 0.065, 0.085, 0.150, 0.180, 0.250];

% Función para calcular el polinomio de Lagrange
function [P, polinomio_str] = lagrange_interpol(t, semanas, pesos)
    n = length(semanas);
    P = 0;
    polinomio_str = '';
    for k = 1:n
        Lk = 1;
        Lk_str = '1';
        for i = 1:n
            if i ~= k
                Lk = Lk * (t - semanas(i)) / (semanas(k) - semanas(i));
                Lk_str = [Lk_str ' * (t - ' num2str(semanas(i)) ') / (' num2str(semanas(k)) ' - ' num2str(semanas(i)) ')'];
            end
        end
        P = P + pesos(k) * Lk;
        if k == 1
            polinomio_str = [polinomio_str num2str(pesos(k)) ' * (' Lk_str ')'];
        else
            polinomio_str = [polinomio_str ' + ' num2str(pesos(k)) ' * (' Lk_str ')'];
        end
    end
end

% Predicción para la semana 3.5
t_pred = 3.5;
[peso_predicho, polinomio_str] = lagrange_interpol(t_pred, semanas, pesos);
fprintf('El peso de los peces en la semana %.1f es aproximadamente: %.4f gramos\n', t_pred, peso_predicho);

% Mostrar el polinomio de Lagrange
fprintf('El polinomio de Lagrange es:\n%s\n', polinomio_str);

% Comprobación en los puntos originales
fprintf('Comprobación en los puntos originales:\n');
for i = 1:length(semanas)
    peso_interp = lagrange_interpol(semanas(i), semanas, pesos);
    fprintf('Semana %d: Peso original = %.4f, Peso interpolado = %.4f\n', semanas(i), pesos(i), peso_interp);
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
