#!/bin/bash -x

# batch job script for Flow Type I @Nagoya Univ.

#PJM -L rscunit=fx
#PJM -L rscgrp=fx-small
#PJM -L node=2
#PJM --mpi proc=2
#PJM -L elapse=30:00
#PJM -j
#PJM -S

echo "######## ######## ######## ########"
module list
echo "######## ######## ######## ########"

BIN1=./singleio
BIN2=./singlefile
BIN3=./multifile
BIN4=./mpiio_singlefile

N=2

echo "1M elements/process = 8MByte/process, 16MByte/total"
mpiexec ${BIN1}_write64 ${N} 1000000 ./8M
mpiexec ${BIN1}_read64  ${N} 1000000 ./8M
mpiexec ${BIN2}_write64 ${N} 1000000 ./16M.dat
mpiexec ${BIN2}_read64  ${N} 1000000 ./16M.dat
mpiexec ${BIN3}_write64 ${N} 1000000 ./8M
mpiexec ${BIN3}_read64  ${N} 1000000 ./8M
mpiexec ${BIN4}_write64 ${N} 1000000 ./16M.dat
mpiexec ${BIN4}_read64  ${N} 1000000 ./16M.dat
echo "10M elements/process = 80MByte/process, 160MB/total"
mpiexec ${BIN1}_write64 ${N} 10000000 ./80M
mpiexec ${BIN1}_read64  ${N} 10000000 ./80M
mpiexec ${BIN2}_write64 ${N} 10000000 ./160M.dat
mpiexec ${BIN2}_read64  ${N} 10000000 ./160M.dat
mpiexec ${BIN3}_write64 ${N} 10000000 ./80M
mpiexec ${BIN3}_read64  ${N} 10000000 ./80M
mpiexec ${BIN4}_write64 ${N} 10000000 ./160M.dat
mpiexec ${BIN4}_read64  ${N} 10000000 ./160M.dat
echo "100M elements/process = 800MByte/process, 1.6G/total"
mpiexec ${BIN1}_write64 ${N} 100000000 ./800M
mpiexec ${BIN1}_read64  ${N} 100000000 ./800M
mpiexec ${BIN2}_write64 ${N} 100000000 ./1.6G.dat
mpiexec ${BIN2}_read64  ${N} 100000000 ./1.6G.dat
mpiexec ${BIN3}_write64 ${N} 100000000 ./800M
mpiexec ${BIN3}_read64  ${N} 100000000 ./800M
mpiexec ${BIN4}_write64 ${N} 100000000 ./1.6G.dat
mpiexec ${BIN4}_read64  ${N} 100000000 ./1.6G.dat
echo "1G elements/process = 8GByte/process, 16GB/total"
mpiexec ${BIN1}_write64 ${N} 1000000000 ./8G
mpiexec ${BIN1}_read64  ${N} 1000000000 ./8G
mpiexec ${BIN2}_write64 ${N} 1000000000 ./16G.dat
mpiexec ${BIN2}_read64  ${N} 1000000000 ./16G.dat
mpiexec ${BIN3}_write64 ${N} 1000000000 ./8G
mpiexec ${BIN3}_read64  ${N} 1000000000 ./8G
mpiexec ${BIN4}_write64 ${N} 1000000000 ./16G.dat
mpiexec ${BIN4}_read64  ${N} 1000000000 ./16G.dat
