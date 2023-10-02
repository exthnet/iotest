iotest: parallel IO testset
measures simple workloads easy

並列IO性能を測定するシンプルなテストセットを作ってみました。
ありがちなIO処理の性能を簡単に測定できます。

- IO pattern
1. singleio: single process uses fwrite/fread and gather/scatter by MPI_(I)Send/(I)Recv
2. singlefile: all processes use fwrite/fread to single file
3. multifile: all processes use fwrite/fread to individual files
4. mpiio: using mpi-io to single file


- build
mkdir workdir
cd workdir
cp ../template/build.sh .
edit build.sh
./build.sh


- execute
see template/*.sh
  job_A_*nodes.sh : batch job script for Flow Type I @Nagoya Univ., on hotstorage
  job_B_*nodes.sh : batch job script for Flow Type II @Nagoya Univ., on hotstorage
  job_B_*nodes_local.sh : batch job script for Flow Type II @Nagoya Univ., on local SSD (MPI-IO is not available)
  job_B_*nodes_beeond.sh : batch job script for Flow Type II @Nagoya Univ., on BeeOND storage


今後何か更新がある場合はgitlabで行います
https://gitlab.com/exthnet/iotest
