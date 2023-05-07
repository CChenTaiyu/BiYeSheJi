function EI = Infill_EI(x,GP_model,fmin, k)
% get the Kriging prediction and variance
[u,s] = GP_Predictor(x,GP_model);
% calcuate the EI value
EI = (fmin-u-k).*normcdf((fmin-u-k)./s)+s.*normpdf((fmin-u-k)./s);
save('Ellipsoid-1-50.mat', 'u');
end





