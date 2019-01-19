function writeDecentrStateToG2oFiles(sim_cp_c_,y2, sim_cp_c,y1, outputDir)
file_ids = fopen(...'
        [outputDir '/' '0.g2o'], 'w');
    file_ids1 = fopen(...'
        [outputDir '/' '1.g2o'], 'w');
    nr_poses = numel(y1);
    file_id = file_ids;
    file_id1 = file_ids1;
    for pose_i = 1:nr_poses
        T_O_C = y1{pose_i};
        T_W_C=[];
        T_W_C(1,1:4)=T_O_C(1,1:4);
        T_W_C(2,1:4)=T_O_C(1,5:8);
        T_W_C(3,1:4)=T_O_C(1,9:12);
        frame_id=pose_i+97 * int64(2^56);
        writeG2oPose(file_id, frame_id,T_W_C);
        
    end
      for pose_i = 1:nr_poses-1
        relative_pose = sim_cp_c{pose_i};
                frame_idx=pose_i+97 * int64(2^56);
        frame_id1x=frame_idx+1;
        writeG2oConstraint(file_id, frame_idx, frame_id1x,relative_pose, eye(6));
      end
    
   query_id = 873+97 * int64(2^56);
        match_id =200+98 * int64(2^56);
     %   aaa=load('/home/caojf/test/test.txt')
  % Sim_M_Q(1,1:4)=aaa(1,1:4);
   % Sim_M_Q(2,1:4)=aaa(1,5:8);
   % Sim_M_Q(3,1:4)=aaa(1,9:12);
   % Sim_M_Q(4,1:4)=[0,0,0,1];
    % Sim_M_Q1=Sim_M_Q ^ -1;
      %T_Q_M = tInv(Sim_M_Q1);
      T_Q_M(1,1:4)=[0.999689884107793,-0.00235937697960424,0.0247881295542263,-0.104933994084032];
      T_Q_M(2,1:4)=[0.00232274360545104,0.999996335963505,0.00150627315613342,0.0159817054712891];
      T_Q_M(3,1:4)=[-0.0247916473148518,-0.00144823582912465,0.999691182902188,0.0933548308265027];
      T_Q_M(4,1:4)=[0,0,0,1];
         writeG2oConstraint(file_id, query_id, match_id, T_Q_M, eye(6));
         writeG2oConstraint(file_id1, query_id, match_id, T_Q_M, eye(6));
        
         nr_poses1 = numel(y2);
    for pose_i1 = 1:nr_poses1
        T_O_C1 = y2{pose_i1};
        T_W_C1=[];
        T_W_C1(1,1:4)=T_O_C1(1,1:4);
        T_W_C1(2,1:4)=T_O_C1(1,5:8);
        T_W_C1(3,1:4)=T_O_C1(1,9:12);
        frame_id1=pose_i1+98 * int64(2^56);
        writeG2oPose(file_id1,frame_id1, T_W_C1);
    end
    for pose_i1 = 1:nr_poses1-1
        relative_pose1 = sim_cp_c_{pose_i1};
                frame_idx1=pose_i1+98 * int64(2^56);
        frame_id1x1=frame_idx1+1;
        writeG2oConstraint(file_id1, frame_idx1, frame_id1x1,relative_pose1, eye(6));
      end

        
    fclose(file_ids);
    fclose(file_ids1);
end