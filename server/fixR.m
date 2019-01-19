function R = fixR(R)

if (abs(det(R) - 1) > 1e-5)
    R
    det(R)
    assert(false);
end

% http://people.csail.mit.edu/bkph/articles/Nearest_Orthonormal_Matrix.pdf
[~, S, V] = svd(R);
S = diag(S);
corr = V(:, 1) * V(:, 1)' / S(1) + ...
    V(:, 2) * V(:, 2)' / S(2) + ...
    V(:, 3) * V(:, 3)' / S(3);

R = R*corr;

end
