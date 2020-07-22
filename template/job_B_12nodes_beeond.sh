#!/bin/bash -x

# batch job script for Flow Type II @Nagoya Univ.
# on BeeOND storage

#PJM -L rscunit=cx
#PJM -L rscgrp=cx-small
#PJM -L node=12
#PJM --mpi proc=12
#PJM -L elapse=30:00
#PJM -x PJM_BEEOND=1
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

N=12

# check PJM_BEEONDDIR
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ./job_B_check_beeond.sh

echo "1M elements/process = 8MByte/process, 96MByte/total"
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 1000000 ${PJM_BEEONDDIR}/8M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 1000000 ${PJM_BEEONDDIR}/8M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 1000000 ${PJM_BEEONDDIR}/96M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 1000000 ${PJM_BEEONDDIR}/96M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 1000000 ${PJM_BEEONDDIR}/8M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 1000000 ${PJM_BEEONDDIR}/8M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 1000000 ${PJM_BEEONDDIR}/96M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 1000000 ${PJM_BEEONDDIR}/96M.dat
echo "10M elements/process = 80MByte/process, 960MB/total"
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 10000000 ${PJM_BEEONDDIR}/80M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 10000000 ${PJM_BEEONDDIR}/80M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 10000000 ${PJM_BEEONDDIR}/960M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 10000000 ${PJM_BEEONDDIR}/960M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 10000000 ${PJM_BEEONDDIR}/80M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 10000000 ${PJM_BEEONDDIR}/80M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 10000000 ${PJM_BEEONDDIR}/960M.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 10000000 ${PJM_BEEONDDIR}/960M.dat
echo "100M elements/process = 800MByte/process, 9.6G/total"
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 100000000 ${PJM_BEEONDDIR}/800M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 100000000 ${PJM_BEEONDDIR}/800M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 100000000 ${PJM_BEEONDDIR}/9.6G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 100000000 ${PJM_BEEONDDIR}/9.6G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 100000000 ${PJM_BEEONDDIR}/800M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 100000000 ${PJM_BEEONDDIR}/800M
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 100000000 ${PJM_BEEONDDIR}/9.6G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 100000000 ${PJM_BEEONDDIR}/9.6G.dat
echo "1G elements/process = 8GByte/process, 96GB/total"
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_write64 ${N} 1000000000 ${PJM_BEEONDDIR}/8G
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN1}_read64  ${N} 1000000000 ${PJM_BEEONDDIR}/8G
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_write64 ${N} 1000000000 ${PJM_BEEONDDIR}/96G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN2}_read64  ${N} 1000000000 ${PJM_BEEONDDIR}/96G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_write64 ${N} 1000000000 ${PJM_BEEONDDIR}/8G
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN3}_read64  ${N} 1000000000 ${PJM_BEEONDDIR}/8G
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_write64 ${N} 1000000000 ${PJM_BEEONDDIR}/96G.dat
mpirun -n ${n} -machinefile $PJM_O_NODEINF -npernode 1 ${BIN4}_read64  ${N} 1000000000 ${PJM_BEEONDDIR}/96G.dat
