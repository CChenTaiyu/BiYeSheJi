function [lower_bound,upper_bound,global_optimum] = Test_Function(fun_name,num_vari)

switch fun_name
    case 'Ellipsoid'
        lower_bound = -5.12*ones(1,num_vari); upper_bound = 5.12*ones(1,num_vari);global_optimum = 0;
    case 'Rosenbrock'
        lower_bound = -2.048*ones(1,num_vari); upper_bound = 2.048*ones(1,num_vari);global_optimum = 0;
    case 'Ackley'
        lower_bound = -32.728*ones(1,num_vari); upper_bound = 32.728*ones(1,num_vari);global_optimum = 0;
    case 'Griewank'
        lower_bound = -600*ones(1,num_vari); upper_bound = 600*ones(1,num_vari);global_optimum = 0;
    case 'Rastrigin'
        lower_bound = -5.12*ones(1,num_vari);upper_bound = 5.12*ones(1,num_vari);global_optimum = 0;
    case 'Sin'
        lower_bound = -5*ones(1,num_vari);upper_bound = 5*ones(1,num_vari); global_optimum = 0;
        
end

