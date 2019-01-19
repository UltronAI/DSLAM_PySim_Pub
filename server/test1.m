load('state.mat');
n=1;
heng=[];
zong=[];
for n=1:700;
    x1=decentr_state{n};
    x=x1(1,4);
    heng=[heng;x];
        y=x1(3,4);
    zong=[zong;y];
end
 plot(heng, zong, '-', 'LineWidth', 3, ...
        'Color', [1 0 0]);