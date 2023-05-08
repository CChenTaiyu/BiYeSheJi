clearvars;
fun_name = 'Rosenbrock';
%Setting the number of local points
l = 30;
% infill name and dimension
infill_name = 'LCB';
num_vari = 10;
% design space
[lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
num_initial = 10*num_vari;
max_evaluation = 500;
% the number of current generation
load(strcat(fun_name,num2str(num_vari),'.mat'),'x');
average = zeros(20, 1);
% the initial design set
count = 1;
z = zeros(max_evaluation -num_initial + 1, 1);
points = linspace(num_initial, max_evaluation, max_evaluation - num_initial + 1);
% the BO iteration
tic
for k = 1:20
    %Setting local set
    local_sample_x = zeros(l+1, num_vari);
    iteration = 1;
    sample_x = x(:,:,k);
    sample_y = feval(fun_name,sample_x);
    evaluation = size(sample_x,1);
    fmin = min(sample_y);
    fprintf('BO on %s, iteration: %d, evaluation: %d, best: %0.4g\n',fun_name,iteration,evaluation,fmin);
    count = 1;
    z(count, 1) = z(count, 1) + fmin;
    count = count + 1;

    while evaluation < max_evaluation
        % full training
        GP_model = GP_Train(sample_x,sample_y,lower_bound,upper_bound,1,1E-6,1E2);
        % finding a new point using the LCB criteriona
        [infill_x1,max_EI1]= Optimizer_GA(@(x)Infill_LCB(x,GP_model,fmin,2),num_vari,lower_bound,upper_bound,100,100);
        %Calculate Euclidean distance
        dist = pdist2(sample_x, infill_x1);
        [sort_dist,sort_index] = sort(dist);
        local_sample_x = sample_x(sort_index(1:l),:);
        local_sample_y = sample_y(sort_index(1:l),:);
        local_fmin=min(local_sample_y);
        % Perform Bayesian optimization in local space
        local_GP_model = GP_Train(local_sample_x,local_sample_y,min(local_sample_x),max(local_sample_x),1,1E-6,1E2);
        [infill_x2,max_EI2]= Optimizer_GA(@(x)Infill_LCB(x,local_GP_model,local_fmin, 0),num_vari,min(local_sample_x),max(local_sample_x),100,100);
        if  max_EI1 < max_EI2
            infill_x=infill_x1;
        else
            infill_x=infill_x2;
        end
        % evaluating the candidate with the real function
        best_y = feval(fun_name,infill_x);
        % add the new point to design set
        sample_x = [sample_x;infill_x];
        sample_y = [sample_y;best_y];
        % update some parameters 
        evaluation = size(sample_x,1);
        iteration = iteration + 1;
        fmin = min(sample_y);
        z(count, 1) = z(count, 1) + fmin;
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
    z(k, 1) = z(k, 1) / 20;
end
%save(strcat(fun_name,'-',num2str(num_vari),'-',num2str(l),'local','.mat'), 'z');
toc