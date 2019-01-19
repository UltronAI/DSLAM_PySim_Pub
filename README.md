# DSLAM_PySim_Pub
Python Simulator for DSLAM (Public Version)

## 环境

### 服务器(局域网ip，可能会变)

#### 1. DSLAM

IP地址: 172.16.0.104

作用：运行MATLAB + 运行server（接收端） + 运行一个发送端

#### 2. zu9_S1

IP地址：172.16.0.113

作用：运行另一个发送端

#### 3. 账号

如果没有自己账号的话可以用我的，找我要就行

### MATLAB环境

地址：`/opt/MATLAB/R2017b/bin/`

命令：在`.bashrc`中添加`export PATH=$PATH:/opt/MATLAB/R2017b/bin/`，保存之后`source ~/.bashrc`

## 文件说明

### 1. pose_files

把pose estimator的输出txt文件分割成几个文件，作为DSLAM的输入

命令：`python split_txt.py --file /path/to/txtfile`，输出的分割后txt文件在`pose_files/output`中

### 2. server

MATLAB server，使用MATLAB运行`serverA.m`

__需修改项__: 把`serverA.m`前两行的groundtruth的地址改为你自己目录下的地址即可（不改其实也问题不大，只是会读取我的目录下的文件）

### 3. MApro

我也不知道是干啥的…目前也没有用到，先留着吧

### 4 . DSLAM_zu9_proj

位姿和Netvlad的发送和接收的服务器端

## 使用说明

### 1. 准备好split过的位姿的txt文件

1. 编号为0的文件放在DSLAM服务器的`$YOURPATH/DSLAM_PySim/DSLAM_zu9_proj/testdata`中

2. 编号为1的文件放在zu9_S1服务器的`$YOURPATH/DSLAM_PySim/DSLAM_zu9_proj/testdata`中

### 2. 修改DSLAM_zu9_proj中的examples/main.cpp

__记得两个服务器中的main.cpp都要修改，DSLAM服务器中使用编号较小的文件__

main.cpp的line44 (修改过的话可能行数会变)：`sim_camera camera("./testdata/gt_1.txt", "./testdata/netvlad_0.txt");`，前一个是pose，后一个是netvlad，改成你要测试的对应的文件即可

### 3. 重新build DSLAM_zu9_proj

进入build目录下，如果第一次使用的话，先删除`CMakeCache.txt`，把`Makefile`中的目录地址修改成你自己的目录，vim的话可以考虑直接使用`:%s/gaof/$YOURPATH/g`

在build目录中`make`

### 4. 运行MATLAB

__运行`serverA.m`之前，删除DSLAM服务器`/home/share/DSLAM/`目录下的txt文件__

在DSLAM服务器中`matlab &`，如果报错的话看看是不是没有把MATLAB路径添加到`~/.bashrc`中，运行`serverA.m`

### 5. 运行DSLAM服务器

#### DSLAM服务器

1. 在`DSLAM_zu9_proj/build`中运行`./server`
2. 在`DSLAM_zu9_proj/build`中运行`./main`

#### zu9_S1服务器

在`DSLAM_zu9_proj/build`中运行`./main`

### 6. 没出错的话MATLAB应该开始画图了，等着就好

图中虚线为真值，实线为估计值，红色为DSLAM服务器中的数据，蓝色为zu9_s1服务器中的数据，会出现的黑色的部分是netvlad计算出的匹配

##### 写到最后发现这个repo中并没怎么用python…
