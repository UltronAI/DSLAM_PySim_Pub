R1=textread('/home/caojf/DSLAM_zu9_proj/GT/R1.txt');
R2=textread('/home/caojf/DSLAM_zu9_proj/GT/R2.txt');
R2GT=textread('/home/caojf/DSLAM_zu9_proj/GT/R2GT.txt');
heng1=[];
zong1=[];
heng2=[];
zong2=[];
heng3=[];
zong3=[];
x1=0:1:1;
y1=-600:1:-599;
plot(x1,y1);
x2=0:pi/50:2*pi;
y2=600;
plot(x2,y2);
for n=1:2001  
    heng1=[heng1;R1(n,1)];
    zong1=[zong1;R1(n,2)];
    heng2=[heng2;R2(n,1)];
    zong2=[zong2;R2(n,2)];
    heng3=[heng3;R2GT(n,1)];
    zong3=[zong3;R2GT(n,2)];

hold on 
c = colormap('lines');


    plot(heng1, zong1, '-', 'LineWidth',3, ...
        'Color', c(1, :));

     h2=plot(heng2, zong2, '-', 'LineWidth',3, ...
        'Color', [1 0 0]);
     if(n==1290)
       h4=plot([-500 -10], [200 0], 'k-x', 'LineWidth', 5);
       pause(0.4)
       
     end
    if(n==1300)
       h5=plot([-500 0], [205 0], 'k-x', 'LineWidth', 5);
       pause(0.4)
    end
    if(n==1310)
       h6=plot([-500 -10], [210 0], 'k-x', 'LineWidth', 5);
       pause(0.4)
       delete(h4);
       delete(h5);
       delete(h6);
    end
       
       

      if((R2(n,1)==-500) && (R2(n,2)<195))
     
      set(h2,'Color','w');
      end
    
        h3=plot(heng3, zong3,  '--', ...
        'Color', [1 0 0],'LineWidth', 2);
       
        
    if((R2GT(n,1)==200)||(R2GT(n,2)==0 && R2GT(n,1)>10))
        
        set(h3,'LineStyle','-', 'LineWidth', 3);
    end
    
    
    pause(0.001)
        axis equal;

    
end