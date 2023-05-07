clearvars;
fun_name = 'Ellipsoid';
num_vari=1;
num_initial = 10*num_vari;
time_run=20;
[lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
%This function is to set the initial points twenty times
x = zeros(num_initial,num_vari,time_run);
for k = 1:time_run
    x(:,:,k) = rand(num_initial,num_vari).*(upper_bound-lower_bound) + lower_bound;
end
save(strcat(fun_name,num2str(num_vari),'.mat'),'x');