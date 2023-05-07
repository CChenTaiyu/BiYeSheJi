clearvars;
fun_name = 'Rastrigin';
% The name of the infill criteria, containing EI, PI and LCB
% The string 'Compare' will compare the plots of the three functions
infill_name = 'LCB';
num_vari = 30;
% design space
[lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
num_initial = 10*num_vari;
max_evaluation = 500;
% the number of current generation
load(strcat(fun_name,num2str(num_vari),'.mat'),'x');
average = zeros(5, 1);
% the initial design set
count = 1;
z07 = zeros(max_evaluation -num_initial + 1, 1);
points = linspace(num_initial, max_evaluation, max_evaluation - num_initial + 1);
% the BO iteration
    tic
    for k = 1:20
        iteration = 1;
        sample_x = x(:,:,k);
        sample_y = feval(fun_name,sample_x);
        evaluation = size(sample_x,1);
        fmin = min(sample_y);
        fprintf('BO on %s, iteration: %d, evaluation: %d, best: %0.4g\n',fun_name,iteration,evaluation,fmin);
        count = 1;
        z07(count, 1) = z07(count, 1) + fmin;
        count = count + 1;
    
        while evaluation < max_evaluation
            % full training
            GP_model = GP_Train(sample_x,sample_y,lower_bound,upper_bound,1,1E-6,1E2);
            % finding a new point using the LCB criterion
            [best_x,max_LCB]= Optimizer_GA(@(x)Infill_LCB(x,GP_model,fmin, 0.7),num_vari,lower_bound,upper_bound,100,100);
            % evaluating the candidate with the real function
            best_y = feval(fun_name,best_x);
            % add the new point to design set
            sample_x = [sample_x;best_x];
            sample_y = [sample_y;best_y];
            % update some parameters 
            evaluation = size(sample_x,1);
            iteration = iteration + 1;
            fmin = min(sample_y);
            z07(count, 1) = z07(count, 1) + fmin;
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
        z07(k, 1) = z07(k, 1)/5;
    end
    save(strcat(fun_name,'-',num2str(num_vari),'.mat'),'z07','-append');
    toc
%z1 is EI result
%z2 is PI result
%z3 is LCB result
%z4 is LCB(k=0.5) result
%z5 is LCB(k=0.5/1) result
%z6 is k = 0

 