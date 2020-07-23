#!/bin/bash -x

# batch job script for Flow Type II @Nagoya Univ.
# on local SSD (MPI-IO is not available)

#PJM -L rscunit=cx
#PJM -L rscgrp=cx-small
#PJM -L node=2
#PJM --mpi proc=2
#PJM -L elapse=30:00
#PJM -j
#PJM -S

echo "######## ######## ######## ########"
module load gcc openmpi
module list
echo "######## ######## ######## ########"

BIN1=./singleio
BIN2=./singlefile
BIN3=./multifile
BIN4=./mpiio_singlefile

N=2

# check PJM_LOCALDIR
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ./job_B_check_local.sh

echo "1M elements/process = 8MByte/process, 16MByte/total"
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 1000000 ${PJM_LOCALDIR}/8M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 1000000 ${PJM_LOCALDIR}/8M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 1000000 ${PJM_LOCALDIR}/16M.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 1000000 ${PJM_LOCALDIR}/16M.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 1000000 ${PJM_LOCALDIR}/8M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 1000000 ${PJM_LOCALDIR}/8M
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 1000000 ${PJM_LOCALDIR}/16M.dat
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 1000000 ${PJM_LOCALDIR}/16M.dat
echo "10M elements/process = 80MByte/process, 160MB/total"
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 10000000 ${PJM_LOCALDIR}/80M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 10000000 ${PJM_LOCALDIR}/80M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 10000000 ${PJM_LOCALDIR}/160M.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 10000000 ${PJM_LOCALDIR}/160M.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 10000000 ${PJM_LOCALDIR}/80M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 10000000 ${PJM_LOCALDIR}/80M
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 10000000 ${PJM_LOCALDIR}/160M.dat
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 10000000 ${PJM_LOCALDIR}/160M.dat
echo "100M elements/process = 800MByte/process, 1.6G/total"
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 100000000 ${PJM_LOCALDIR}/800M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 100000000 ${PJM_LOCALDIR}/800M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 100000000 ${PJM_LOCALDIR}/1.6G.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 100000000 ${PJM_LOCALDIR}/1.6G.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 100000000 ${PJM_LOCALDIR}/800M
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 100000000 ${PJM_LOCALDIR}/800M
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 100000000 ${PJM_LOCALDIR}/1.6G.dat
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 100000000 ${PJM_LOCALDIR}/1.6G.dat
echo "1G elements/process = 8GByte/process, 16GB/total"
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 1000000000 ${PJM_LOCALDIR}/8G
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 1000000000 ${PJM_LOCALDIR}/8G
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 1000000000 ${PJM_LOCALDIR}/16G.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 1000000000 ${PJM_LOCALDIR}/16G.dat
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 1000000000 ${PJM_LOCALDIR}/8G
mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 1000000000 ${PJM_LOCALDIR}/8G
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 1000000000 ${PJM_LOCALDIR}/16G.dat
#mpirun -n ${N} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 1000000000 ${PJM_LOCALDIR}/16G.dat
