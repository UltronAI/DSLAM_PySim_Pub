function decentr_state1 = readDecentrStateFromOptG2oFiles1(...
    n,g2o_dir, decentr_state1, suffix)
% Inspired by Luca Carlone's
% https://bitbucket.org/lucacarlone/pgo3d-duality-opencode/src/ebb6e1b8cebaad7f2aaf581b1d0c0bad737faebb/lib/readG2oDataset3D.m?at=master&fileviewer=file-view-default

file_id1 = fopen(...
        [g2o_dir '/' num2str(1) suffix '.g2o'], 'r');
    mm=1;
   for ddd=1:n
        line = fgets(file_id1);
        data = textscan(line, '%s %d64 %f %f %f %f %f %f %f');

        x = data{3}; y = data{4}; z = data{5};
        qx = data{6}; qy = data{7}; qz = data{8}; qw = data{9};
        
        Sim_W_C = eye(4);
        Sim_W_C(1:3, 4) = [x y z]';
        q = [qw, qx qy, qz]';
        if(abs(norm(q)-1) > 1e-3)
            norm(q)
            error('Quaternion has not unit norm');
        else
            q = q/norm(q); % we normalize anyway
        end
        
        Sim_W_C(1:3, 1:3) = fixR(quat2rot(q));
        
        decentr_state1{mm} = Sim_W_C;
        mm=mm+1;
    end

fclose(file_id1);
end