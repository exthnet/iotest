- build
mkdir workdir
cp ../template/build.sh .
edit build.sh
./build.sh

- execute
see template/*.sh
  job_A_*nodes.sh : batch job script for Flow Type I @Nagoya Univ.
  job_B_*nodes.sh : batch job script for Flow Type II @Nagoya Univ., on hotstorage
  job_B_*nodes_local.sh : batch job script for Flow Type II @Nagoya Univ., on local SSD (MPI-IO is not available)
  job_B_*nodes_beeond.sh : batch job script for Flow Type II @Nagoya Univ., on BeeOND storage

