outputDir = ['dgs_data/1'];
max_iters=20;
distributed_mapper_location='/home/caojf/MApro/distributed-mapper/cpp/build/runDistributedMapper';
assert(system([distributed_mapper_location ' --dataDir ' pwd '/' ...
    outputDir '/ --nrRobots ' num2str(2)...
    ' --traceFile ' pwd '/' outputDir '/trace --maxIter ' ...
    num2str(max_iters)]) == 0);

