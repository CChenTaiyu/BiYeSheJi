function LCB = Infill_LCB(x,GP_model,fmin, k)
% get the Kriging prediction and variance
[u,s] = GP_Predictor(x,GP_model);
% calcuate the LCB value
%set the parameter
LCB = u - k.*s;
end