
    
     b=textread('/home/caojf/DSLAM_zu9_proj/GT/pose_gt_1.txt');
    d=textread('/home/caojf/DSLAM_zu9_proj/GT/pose_gt_0.txt');
     k1=cell(2261,1);
     y1={};
     z1=cell(2261,1);    
     netvlad1=[];
     bheng=[];
    bzong=[];
     dheng=[];
     dzong=[];
     heng1=[];
     zong1=[];
     k2=cell(2261,1);
     y2={};
     z2=cell(2261,1);    
     netvlad2=[];
     heng2=[];
     zong2=[];
     c1=[];
     b1=[];
     decentr_state=cell(2261,1);
     decentr_state1=cell(2261,1);
     sim_o_c=cell(2261,1);
     sim_cp_c=cell(2261,1);
     
     outputDir = ['dgs_data/1'];
mkdir(outputDir);
max_iters=20;
jishu=0;
jishu1=[];
jishu2=[];
jishu3=[];
   for n=1:2000
     while(  (~exist('/home/share/DSLAM/2652874944_data.txt','file') || exist('/home/share/DSLAM/2652874944_lock.txt','file') ))
         pause(0.1)
       disp('waiting\n')
     end
        while(  (~exist('/home/share/DSLAM/2736761024_data.txt','file') || exist('/home/share/DSLAM/2736761024_lock.txt','file') ))
         pause(0.1)
     end
     disp(num2str(n))
    a=textread('/home/share/DSLAM/2652874944_data.txt');

    a1=a(1,1);
    b1=b(a1,:);
    bheng=[bheng,b1(1,4)];
     bzong=[bzong,b1(1,12)];
     x(1,1)=b1(1,4);
     x(1,2)=b1(1,12);
        d1=d(a1,:);
   dheng=[dheng,d1(1,4)];
     dzong=[dzong,d1(1,12)];
     
    a2=a(2,1:16);
    T_W_C=[];
        T_W_C(1,1:4)=a2(1,1:4);
        T_W_C(2,1:4)=a2(1,5:8);
        T_W_C(3,1:4)=a2(1,9:12);
        T_W_C(4,1:4)=[0,0,0,1];
        sim_o_c{n}=T_W_C;
        sim_cp_c{1}=eye(4);
        if(n>1)
        sim_cp_c{n}=sim_o_c{n-1} ^ -1 * sim_o_c{n};    
        end
    heng1=[heng1;a2(1,4)];
    zong1=[zong1;a2(1,12)];
    a3=a(3,1:128);   
    a4=a3';
    netvlad1(1:128,n) =a4;
    query_netvlad1 = a3';
    k1{n}=a1;
    y1{n}=a2;
    z1{n}=a3;
    delete('/home/share/DSLAM/2652874944_data.txt');
     disp('deleted\n')
     
    a_=textread('/home/share/DSLAM/2736761024_data.txt'); 
    a1_=a_(1,1);
    a2_=a_(2,1:16); 
    T_W_C_=[];
        T_W_C_(1,1:4)=a2_(1,1:4);
        T_W_C_(2,1:4)=a2_(1,5:8);
        T_W_C_(3,1:4)=a2_(1,9:12);
        T_W_C_(4,1:4)=[0,0,0,1];
        sim_o_c_{n}=T_W_C_;
        sim_cp_c_{1}=eye(4);
        if(n>1)
        sim_cp_c_{n}=sim_o_c_{n-1} ^ -1 * sim_o_c_{n};    
        end
    
    heng2=[heng2;a2_(1,4)];
    zong2=[zong2;a2_(1,12)];
    y(1:n,1)=heng2;
    y(1:n,2)=zong2;
    a3_=a_(3,1:128);   
    a4_=a3_';
    netvlad2(1:128,n) =a4_;
    query_netvlad2 = a3_';
    k2{n}=a1_;
    y2{n}=a2_;
    z2{n}=a3_;
    delete('/home/share/DSLAM/2736761024_data.txt');
%[distance, I] = ...
 %   pdist2(x, ...
 %   y, 'squaredeuclidean', 'Smallest', 1);
 % jishu=sum(sum(distance<15));
 % if (jishu > 0)
 
[distance12, best_frame12] = ...
    pdist2(netvlad2(:, 1:n)', ...
    query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
if (distance12<0.01)
   jishu=1;
end
 if(jishu==1)
writeDecentrStateToG2oFiles(sim_cp_c_,y2, sim_cp_c,y1, outputDir);
distributed_mapper_location='~/MApro/distributed-mapper/cpp/build/runDistributedMapper';
    assert(system([distributed_mapper_location ' --dataDir ' pwd '/' ...
    outputDir '/ --nrRobots ' num2str(2)...
    ' --traceFile ' pwd '/' outputDir '/trace --maxIter ' ...
    num2str(max_iters)]) == 0);

decentr_state = readDecentrStateFromOptG2oFiles(...
   n, outputDir, decentr_state, '_optimized');
decentr_state1 = readDecentrStateFromOptG2oFiles1(...
   n, outputDir, decentr_state1, '_optimized');


clf;

   hold on;
c = colormap('lines');


  plot(heng2, zong2, '-', 'LineWidth', 3, ...
        'Color', [1 0 0]);
     plot(bheng, bzong,  '-', 'LineWidth', 3, ...
        'Color', c(1, :));
    
     plot(dheng, dzong,  '--', ...
        'Color', [0 1 0]);
    [distance22, best_frame22] = ...
    pdist2(netvlad2(:, 1:n-30)', ...
    query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
if (distance22 < 0.01)
   to7=zong2(best_frame22,1);
    to8=heng2(best_frame22,1);
   
     plot([a2_(1,4) to8], [a2_(1,12) to7], 'k-x', 'LineWidth', 5);
end
  end
 if (jishu == 0)
     hold on;
c = colormap('lines');
plot(heng1, zong1, '-', 'LineWidth', 3, ...
        'Color', c(1, :));
  plot(heng2, zong2, '-', 'LineWidth', 3, ...
        'Color', [1 0 0]);
     plot(bheng, bzong,  '--', ...
        'Color', c(1, :));
    
     plot(dheng, dzong,  '--', ...
        'Color', [0 1 0]);
if(n>30)
     [distance11, best_frame11] = ...
    pdist2(netvlad1(:, 1:n-30)', ...
    query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
if (distance11 < 0.01)
    to2=zong1(best_frame11,1);
    to1=heng1(best_frame11,1);
plot([a2(1,4) to1], [a2(1,12) to2], 'k-x', 'LineWidth', 5);

end
 
     


[distance12, best_frame12] = ...
    pdist2(netvlad2(:, 1:n-10)', ...
    query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
if (distance12 < 0.01)
    jishu1=[jishu1;n];
    jishu3=[jishu3;best_frame12];
    to4=zong2(best_frame12,1);
    to3=heng2(best_frame12,1);
     plot([a2(1,4) to3], [a2(1,12) to4], 'k-x', 'LineWidth', 5);
end
[distance21, best_frame21] = ...
    pdist2(netvlad1(:, 1:n-10)', ...
    query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
if (distance21 < 0.01)
    jishu2=[jishu2;n];
    to5=zong1(best_frame21,1);
     to6=heng1(best_frame21,1);
      plot([a2_(1,4) to6], [a2_(1,12) to5], 'k-x', 'LineWidth', 5);
end

[distance22, best_frame22] = ...
    pdist2(netvlad2(:, 1:n-30)', ...
    query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
if (distance22 < 0.01)
   to7=zong2(best_frame22,1);
    to8=heng2(best_frame22,1);
   
     plot([a2_(1,4) to8], [a2_(1,12) to7], 'k-x', 'LineWidth', 5);
end

end
 end
    
    
    hold off;

axis equal;

 
   end