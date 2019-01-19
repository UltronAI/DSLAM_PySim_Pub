function writeDecentrStateToG2oFiles_(sim_cp_c_,y2, outputDir)
file_ids = fopen(...'
        [outputDir '/' '1.g2o'], 'w');
    nr_poses = numel(y2);
    file_id = file_ids; 
    for pose_i = 1:nr_poses
        T_O_C = y2{pose_i};
        T_W_C=[];
        T_W_C(1,1:4)=T_O_C(1,1:4);
        T_W_C(2,1:4)=T_O_C(1,5:8);
        T_W_C(3,1:4)=T_O_C(1,9:12);
        frame_id=pose_i+98 * int64(2^56);
        writeG2oPose(file_id,frame_id, T_W_C);
    end
    for pose_i = 1:nr_poses-1
        relative_pose = sim_cp_c_{pose_i};
                frame_idx=pose_i+98 * int64(2^56);
        frame_id1x=frame_idx+1;
        writeG2oConstraint(file_id, frame_idx, frame_id1x,relative_pose, eye(6));
      end
    fclose(file_ids);
end