#!/bin/bash -x

# Fujitsu
#MPICC=mpifccpx
#OPT=

# common
#MPICC=mpicc
#OPT=

# singleio
#   single process recvs by MPI, and writes to singlefile
#   single process reads form singlefile, and send by MPI
${MPICC} ${OPT} -o singleio_write64 ../singleio/singleio_write64.c
${MPICC} ${OPT} -o singleio_read64 ../singleio/singleio_read64.c

# singlefile
#   multi process write to singlefile
#   multi process read from singlefile
${MPICC} ${OPT} -o singlefile_write64 ../singlefile/singlefile_write64.c
${MPICC} ${OPT} -o singlefile_read64 ../singlefile/singlefile_read64.c

# multifile
#   multi process write to individual files
#   multi process read from individual files
${MPICC} ${OPT} -o multifile_write64 ../multifile/multifile_write64.c
${MPICC} ${OPT} -o multifile_read64 ../multifile/multifile_read64.c

# mpiio_singlefile: mpi-io
${MPICC} ${OPT} -o mpiio_singlefile_write64 ../mpiio_singlefile/mpiio_singlefile_write64.c
${MPICC} ${OPT} -o mpiio_singlefile_read64 ../mpiio_singlefile/mpiio_singlefile_read64.c
