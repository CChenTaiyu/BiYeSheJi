clearvars;
fun_name = 'Ellipsoid';
% The name of the infill criteria, containing EI, PI and LCB
% The string 'Compare' will compare the plots of the three functions
infill_name = 'EI';
num_vari = 1;
% design space
[lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
num_initial = 10*num_vari;
max_evaluation = 50;
% the number of current generation
load(strcat(fun_name,num2str(num_vari),'.mat'),'x');
average = zeros(5, 1);
z1 = zeros(max_evaluation -num_initial + 1, 1);
%circulate twenty times
for k = 1:20
    iteration = 1;
    sample_x = x(:,:,k);
    sample_x = sort(sample_x);
    sample_y = feval(fun_name,sample_x);
    evaluation = size(sample_x,1);
    % print current best objective value
    fmin = min(sample_y);
    fprintf('BO on %s, iteration: %d, evaluation: %d, best: %0.4g\n',fun_name,iteration,evaluation,fmin);
    count = 1;
    z1(count, 1) = z1(count, 1) + fmin;
    count = count + 1;
    % the BO iteration
    while evaluation < max_evaluation
        % full training
        GP_model = GP_Train(sample_x,sample_y,lower_bound,upper_bound,1,1E-6,1E2);
        % finding a new point using the EI criterion
        [best_x,max_EI]= Optimizer_GA(@(x)-Infill_EI(x,GP_model,fmin,0),num_vari,lower_bound,upper_bound,100,100);
        % evaluating the candidate with the real function
        best_y = feval(fun_name,best_x);
        % add the new point to design set
        sample_x = [sample_x;best_x];
        sample_y = [sample_y;best_y];
        % update some parameters
        evaluation = size(sample_x,1);
        iteration = iteration + 1;
        fmin = min(sample_y);
        z1(count, 1) = z1(count, 1) + fmin;
        count = count + 1;
        % print current best objective value
        fprintf('Circulation: %d / 20, BO on %s, iteration: %d, evaluation: %d, best: %0.4g\n', k, fun_name,iteration,evaluation,fmin);
    end
    average(k, 1) = fmin;
end
sum = 0;
for k = 1:20
    sum = double(sum) + average(k, 1);
end
fprintf("The average is %f", (sum / 20));
for k = 1:max_evaluation -num_initial + 1
    z1(k, 1) = z1(k, 1) / 20;
end
%z1: parameter of EI is 0
%z11: parameter of EI is 0.01
%z111: parameter of EI is 0.1
%zr: the same parameter with obtain minimum LCB


% load(strcat(fun_name,'-',num2str(num_vari),'-',num2str(50),'.mat'), 'GP_model');
% x = sort(GP_model.sample_x);
% y = feval(fun_name,x);
% x=x';
% y=y';
% xx=-5:0.01:4.852366394148303;
% yy=spline(x,y,xx); %三次样条插值函数
% plot(xx,yy,'b','LineWidth',1.2); 
% hold on;
% fplot(@(x) sin(x), '--',LineWidth=1.2, MarkerFaceColor=[0 0 1]);
% legend('30-eval','true-sin')
% set(gca, 'FontSize',12)
% hold off;

% load(strcat(fun_name,'-',num2str(num_vari),'-',num2str(300),'.mat'), 'GP_model');
% x = sort(GP_model.sample_x);
% y = sin(x);
% x=x';
% y=y';
% xx=-5:0.01:4.852366394148303;
% yy=spline(x,y,xx); %三次样条插值函数
% plot(x,y,'ro',xx,yy,'b','LineWidth',1.2); 
% plot(x, y,LineWidth=1.2, MarkerFaceColor=[0.8500 0.3250 0.0980]);
% hold on;

% plot(x,y,'ro',LineWidth=1.2);
% hold off;
% % fplot(@(x) sin(x));
% % hold on;
% x = x';
% y = y';
% points = [x;y];
% values=spcrv(points,3,10000);
% plot(values(1,:),values(2,:));
% hold off;
