function writeG2oPose(file_id, frame_id,T_W_C)


x = T_W_C(1, 4); y = T_W_C(2, 4); z = T_W_C(3, 4);
R = T_W_C(1:3, 1:3);
assert(sum(sum(imag(R))) == 0);
% Seems to be necessary to avoid complex quaternions
% (to avoid trace(R) < -1)
R = R / (det(R) + 1e-5);
q = rot2quat(R, 1e-4);
%quat2rot(q) - R
%assert(all(all(quat2rot(q) - R < 1e-5)));
assert(norm(q)>1e-3);
q = q/norm(q);
assert(norm(q)>1e-3);
qw = q(1); qx = q(2); qy = q(3); qz = q(4);
if (sum(imag(q)) ~= 0)
    q
    assert(false)
end



fprintf(file_id, ...
    'VERTEX_SE3:QUAT %d %f %f %f %f %f %f %f\n', ...
    frame_id, x, y, z, qx, qy, qz, qw);

end
