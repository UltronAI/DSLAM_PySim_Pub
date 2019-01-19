   %  b=textread('/home/caojf/DSLAM_zu9_proj/GT/gt_1.txt');
  % d=textread('/home/caojf/DSLAM_zu9_proj/GT/gt_2.txt');
     k1=cell(2261,1);
     y1=cell(2261,1);
     z1=cell(2261,1);    
     netvlad1=[];
   %  bheng=[];
  %  bzong=[];
  %   dheng=[];
   %  dzong=[];
     heng1=[];
     zong1=[];
     k2=cell(2261,1);
     y2=cell(2261,1);
     z2=cell(2261,1);    
     netvlad2=[];
     heng2=[];
     zong2=[];
     c1=[];
     b1=[];

   for n=1:2261
   %  while(  (~exist('/home/share/DSLAM/2652874944_data.txt','file') || exist('/home/share/DSLAM/2652874944_lock.txt','file') ))
     %    pause(0.1)
     %    disp('waiting\n')
    % end
        while(  (~exist('/home/share/DSLAM/2736761024_data.txt','file') || exist('/home/share/DSLAM/2736761024_lock.txt','file') ))
         pause(0.1)
     end
     disp(num2str(n))
  %  a=textread('/home/share/DSLAM/2652874944_data.txt');

    a1=a(1,1);
  %  b1=b(a1,:);
  %  bheng=[bheng,b1(1,4)];
 %    bzong=[bzong,b1(1,12)];
  %      d1=d(a1,:);
  % dheng=[dheng,d1(1,4)];
    % dzong=[dzong,d1(1,12)];
     
    a2=a(2,1:16);
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
    heng2=[heng2;a2_(1,4)];
    zong2=[zong2;a2_(1,12)];
    a3_=a_(3,1:128);   
    a4_=a3_';
    netvlad2(1:128,n) =a4_;
    query_netvlad2 = a3_';
    k2{n}=a1_;
    y2{n}=a2_;
    z2{n}=a3_;
    delete('/home/share/DSLAM/2736761024_data.txt');


     hold on;
c = colormap('lines');
 plot(heng1, zong1, '-', 'LineWidth', 3, ...
        'Color', c(1, :));
  plot(heng2, zong2, '-', 'LineWidth', 3, ...
        'Color', [1 0 0]);
    % plot(bheng, bzong,  '--', ...
    %    'Color', c(1, :));
    
     %plot(dheng, dzong,  '--', ...
    %    'Color', [0 1 0]);
if(n>10)
     [distance11, best_frame11] = ...
    pdist2(netvlad1(:, 1:n-10)', ...
    query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
if (distance11 < 0.01)
    to2=zong1(best_frame11,1);
    to1=heng1(best_frame11,1);
%plot([a2(1,4) to1], [a2(1,12) to2], 'k-x', 'LineWidth', 5);

end
 
     end


[distance12, best_frame12] = ...
    pdist2(netvlad2(:, 1:n-10)', ...
    query_netvlad1', 'squaredeuclidean', 'Smallest', 1);
if (distance12 < 0.01)
    to4=zong2(best_frame12,1);
    to3=heng2(best_frame12,1);
   %  plot([a2(1,4) to3], [a2(1,12) to4], 'k-x', 'LineWidth', 5);
end
[distance21, best_frame21] = ...
    pdist2(netvlad1(:, 1:n-10)', ...
    query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
if (distance21 < 0.01)
    to5=zong1(best_frame21,1);
     to6=heng1(best_frame21,1);
    %  plot([a2_(1,4) to6], [a2_(1,12) to5], 'k-x', 'LineWidth', 5);
end

[distance22, best_frame22] = ...
    pdist2(netvlad2(:, 1:n-10)', ...
    query_netvlad2', 'squaredeuclidean', 'Smallest', 1);
if (distance22 < 0.01)
   to7=zong2(best_frame22,1);
    to8=heng2(best_frame22,1);
   
  %   plot([a2_(1,4) to8], [a2_(1,12) to7], 'k-x', 'LineWidth', 5);
end


    
    
    hold off;

axis equal;
 
   end

     
     
     

     
     

  
