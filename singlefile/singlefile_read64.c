#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char **argv)
{
  // ./a.out num_processes elements/process filename
  int nprocs;
  int nelems;
  char *fname;
  int rank, nranks;
  int name_len;
  char name[MPI_MAX_PROCESSOR_NAME];
  int ret;
  double *data;
  double d1, d2;

  if(argc!=4){
	printf("usage: %s num_procs elements/process filename\n", argv[0]);
	return -1;
  }
  nprocs = atoi(argv[1]);
  nelems = atol(argv[2]);
  fname  = argv[3];

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &rank);
  MPI_Comm_size (MPI_COMM_WORLD, &nranks);
  MPI_Get_processor_name(name, &name_len);
  printf("%d/%d %s, %d elements, %d KByte, %s\n", rank, nranks, name, nelems, (nelems/1000)*8, fname); fflush(stdout);
  if(nranks!=nprocs){printf("nranks != nprocs\n"); return -1;}

  data = (double*)malloc(sizeof(double)*nelems);
  if(data==NULL){printf("malloc failed\n"); fflush(stdout); MPI_Abort(MPI_COMM_WORLD,-1); return -1;}
  MPI_Barrier(MPI_COMM_WORLD);
  d1 = MPI_Wtime();
  {
	FILE *F;
	F = fopen(fname, "r");
	if(F==NULL){printf("failed to open %s for read\n", fname); MPI_Abort(MPI_COMM_WORLD,-1); return -1;}
	fseek(F, sizeof(double)*nelems*rank, SEEK_SET);
	ret = fread(data, sizeof(double), nelems, F);
	fclose(F);
	if(ret!=nelems){printf("fread failed(%ld)\n", ret); MPI_Abort(MPI_COMM_WORLD,-1); return -1;}
  }
  d2 = MPI_Wtime() - d1;
  double dmin, dmax, dsum;
  MPI_Reduce(&d2, &dmin, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dmax, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dsum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  if(rank==0)printf("singlefile_read64: min %.2f sec, max %.2f sec, avg %.2f sec\n", dmin, dmax, dsum/(double)nranks);

  free(data);
  MPI_Finalize();
  return 0;
}
