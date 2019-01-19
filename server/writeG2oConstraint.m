function writeG2oConstraint(file_id, from_id, to_id, T_from_to, covariance)
% Adapted from Luca Carlone's
% https://bitbucket.org/lucacarlone/pgo3d-duality-opencode/src/ebb6e1b8cebaad7f2aaf581b1d0c0bad737faebb/lib/writeG2oDataset3D.m?at=master&fileviewer=file-view-default

dt = T_from_to(1:3, 4);
dx = dt(1); dy = dt(2); dz = dt(3);
dR = T_from_to(1:3, 1:3);
dq = rot2quat(dR);
assert(all(imag(dq)==0));
if norm(dq)>1e-3
    dq = dq/norm(dq);
else
    error('norm close to zero for unit quaternion (2)')
end
dqw = dq(1); dqx = dq(2); dqy = dq(3); dqz = dq(4);
I = covariance;

fprintf(file_id,'EDGE_SE3:QUAT %d %d   %f %f %f   %.7f %.7f %.7f %.7f   %f %f %f %f %f %f   %f %f %f %f %f   %f %f %f %f   %f %f %f   %f %f   %f\n', ...
    from_id, to_id, dx, dy, dz, dqx, dqy, dqz, dqw, ...
    I(1,1), I(1,2), I(1,3), I(1,4), I(1,5), I(1,6), ...
    I(2,2), I(2,3), I(2,4), I(2,5), I(2,6), ...
    I(3,3), I(3,4), I(3,5), I(3,6), ...
    I(4,4), I(4,5), I(4,6), ...
    I(5,5), I(5,6), ...
    I(6,6));

end