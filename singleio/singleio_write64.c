#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char **argv)
{
  // ./a.out num_processes elms/process filename
  int nprocs;
  int nelems;
  char *fname;
  int rank, nranks;
  int name_len;
  char name[MPI_MAX_PROCESSOR_NAME];
  int ret;
  MPI_Status status;
  MPI_Request *req;
  double *data;
  double d1, d2;
  int i;

  if(argc!=4){
	printf("usage: %s num_procs elems/process filename\n", argv[0]);
	return -1;
  }
  nprocs = atoi(argv[1]);
  nelems = atoi(argv[2]);
  fname  = argv[3];

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &rank);
  MPI_Comm_size (MPI_COMM_WORLD, &nranks);
  MPI_Get_processor_name(name, &name_len);
  printf("%d/%d %s, %d elements, %d KByte, %s_*.dat\n", rank, nranks, name, nelems, (nelems/1000)*8, fname); fflush(stdout);
  if(nranks!=nprocs){printf("nranks != nprocs\n"); fflush(stdout); return -1;}

  data = (double*)malloc(sizeof(double)*nelems);
  for(i=0; i<nelems; i++){
	data[i] = (double)(i%0x100) + (double)rank*0.01;
  }
  if(rank==0)req = (MPI_Request*)malloc(sizeof(MPI_Request)*(nprocs-1));
  else req = (MPI_Request*)malloc(sizeof(MPI_Request)*1);
  MPI_Barrier(MPI_COMM_WORLD);
  d1 = MPI_Wtime();
  if(rank==0){
	int i;
	FILE *F;
	char fname2[0xff];
	// self
	{
	  snprintf(fname2, 0xff, "%s_%d.dat", fname, 0);
	  F = fopen(fname2, "w");
	  if(F==NULL){printf("failed to open %s for write\n", fname2); fflush(stdout); return -1;}
	  ret = fwrite(data, sizeof(double), nelems, F);
	  fclose(F);
	  if(ret!=nelems){printf("fwrite failed(%d)\n", ret); fflush(stdout); return -1;}
	}
	for(i=1; i<nprocs; i++){
	  ret = MPI_Recv(data, nelems, MPI_DOUBLE, i, 0, MPI_COMM_WORLD, &status);
	  if(ret!=MPI_SUCCESS){printf("MPI_Recv failed (proc %d)\n", rank); fflush(stdout); MPI_Abort(MPI_COMM_WORLD, -1);}
	  snprintf(fname2, 0xff, "%s_%d.dat", fname, i);
	  F = fopen(fname2, "w");
	  if(F==NULL){printf("failed to open %s for write\n", fname2); fflush(stdout); return -1;}
	  ret = fwrite(data, sizeof(double), nelems, F);
	  fclose(F);
	  if(ret!=nelems){printf("fwrite failed(%d)\n", ret); fflush(stdout); return -1;}
	}
  }else{
	ret = MPI_Send(data, nelems, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
	if(ret!=MPI_SUCCESS){printf("MPI_Send failed (proc %d)\n", rank); fflush(stdout); MPI_Abort(MPI_COMM_WORLD, -1);}
  }
  d2 = MPI_Wtime() - d1;
  double dmin, dmax, dsum;
  MPI_Reduce(&d2, &dmin, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dmax, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dsum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  if(rank==0)printf("singleio_write64: min %.4f sec, max %.4f sec, avg %.4f sec\n", dmin, dmax, dsum/(double)nranks);

  free(req);
  free(data);
  MPI_Finalize();
  return 0;
}
