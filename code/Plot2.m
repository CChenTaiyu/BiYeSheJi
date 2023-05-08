fun_name = 'Griewank';
num_vari = 30;
num_initial = 10*num_vari;
max_evaluation = 500;
marker_indices = 50;
line_width = 2;

points = linspace(num_initial, max_evaluation, max_evaluation - num_initial + 1);
a = load(strcat(fun_name,'-',num2str(num_vari),'.mat'),'LCB_result');
b = load(strcat(fun_name,'-',num2str(num_vari),'.mat'),'z3');
c = load(strcat(fun_name,'-',num2str(num_vari),'-LCB', num2str(2), '.mat'),'z');
d = load(strcat(fun_name,'-',num2str(num_vari),'-LCB', num2str(3), '.mat'),'z');
p = plot(points, log(a.LCB_result.z0), points, log(b.z3), points, log(c.z), points, log(d.z));
%Setting the first plot
p(1).LineWidth = line_width;
p(1).Marker = 'o';
p(1).MarkerIndices = 1:marker_indices:length(a.LCB_result.z0);
p(1).MarkerFaceColor = [0.3010 0.7450 0.9330];
%Setting the second plot
p(2).LineWidth = line_width;
p(2).Color = 'm';
p(2).Marker = 'x';
p(2).MarkerIndices = 1:marker_indices:length(b.z3);
p(2).MarkerFaceColor = [0.8500 0.3250 0.0980];
%Setting the third plot
p(3).LineWidth = line_width;
p(3).Marker = 'diamond';
p(3).MarkerIndices = 1:marker_indices:length(c.z);
p(3).MarkerFaceColor = [0.4660 0.6740 0.1880];
%Setting the fourth plot
p(4).LineWidth = line_width;
p(4).Marker = 'pentagra';
p(4).MarkerIndices = 1:marker_indices:length(d.z);
p(4).MarkerFaceColor = [0 0 1];
%Setting the fifth plot
%p(5).LineWidth = line_width;
%p(5).Marker = 'square';
%p(5).MarkerIndices = 1:marker_indices:length(LCB_result_3.z5);
%p(5).MarkerFaceColor = [1 1 0];

title(strcat(fun_name,'-',num2str(num_vari)))
xlabel('Evaluation')
ylabel('fmin')
legend('LCB0','LCB1','LCB2','LCB3','FontSize',15)
set(gca, 'FontSize',20)
%legend('LCB0','LCB1','LCB2','LCB3','FontSize',15)