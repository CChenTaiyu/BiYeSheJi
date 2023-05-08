function y = Schwefel(x)
% Schwefel function
% xi = [-400,400]
y = sum(-x.*sin(sqrt(abs(x))),2) + 418.9829*size(x,2);
end

