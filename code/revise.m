fun_name = 'Griewank';
num_vari = 20;

EI_result = load(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'z1');
save(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'EI_result', '-append');

PI_result = load(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'z2');
save(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'PI_result', '-append');

LCB_result = load(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'z0');
save(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'LCB_result', '-append');

%LCB_result_2 = load(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'z4');
%save(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'LCB_result_2', '-append');

%LCB_result_3 = load(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'z5');
%save(strcat(fun_name,'-',num2str(num_vari),'.mat'), 'LCB_result_3', '-append');