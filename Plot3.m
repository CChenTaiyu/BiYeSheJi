fun_name = 'Rastrigin';
num_vari = 30;
if num_vari == 10
    l = 30;
elseif num_vari == 20
    l = 65;
else
    l = 100;
end
num_initial = 10*num_vari;
max_evaluation = 500;
marker_indices = 50;
line_width = 2;

points = linspace(num_initial, max_evaluation, max_evaluation - num_initial + 1);
a = load(strcat(fun_name,'-',num2str(num_vari),'-',num2str(l),'local','.mat'),'z');
b = load(strcat(fun_name,'-',num2str(num_vari),'.mat'),'z3');
%c = load(strcat(fun_name,'-',num2str(num_vari),'.mat'),'z3');
p = plot(points, log(a.z), points, log(b.z3));
%Setting the first plot
p(1).LineWidth = line_width;
p(1).Marker = 'o';
p(1).MarkerIndices = 1:marker_indices:length(a.z);
p(1).MarkerFaceColor = [0.3010 0.7450 0.9330];
%Setting the second plot
p(2).LineWidth = line_width;
p(2).Color = 'm';
p(2).Marker = 'x';
p(2).MarkerIndices = 1:marker_indices:length(b.z3);
p(2).MarkerFaceColor = [0.8500 0.3250 0.0980];
%Setting the third plot
% p(3).LineWidth = line_width;
% p(3).Marker = 'diamond';
% p(3).MarkerIndices = 1:marker_indices:length(c.z3);
% p(3).MarkerFaceColor = [0.4660 0.6740 0.1880];
%Setting the fourth plot
%p(4).LineWidth = line_width;
%p(4).Marker = 'pentagra';
%p(4).MarkerIndices = 1:marker_indices:length(LCB_result_2.z4);
%p(4).MarkerFaceColor = [0 0 1];
%Setting the fifth plot
%p(5).LineWidth = line_width;
%p(5).Marker = 'square';
%p(5).MarkerIndices = 1:marker_indices:length(LCB_result_3.z5);
%p(5).MarkerFaceColor = [1 1 0];

title(strcat(fun_name,'-',num2str(num_vari)))
xlabel('Evaluation')
ylabel('fmin')
legend('LCB-R(k1=0.7,k2=0)','LCB')
set(gca, 'FontSize',20)