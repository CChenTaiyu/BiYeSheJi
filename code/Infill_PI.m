function PI = Infill_PI(x,GP_model,fmin, k)
% get the Kriging prediction and variance
[u,s] = GP_Predictor(x,GP_model);
% calcuate the PI value
PI = normcdf((fmin - u - k)./s);
end