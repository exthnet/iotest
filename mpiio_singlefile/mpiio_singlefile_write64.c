#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#ifdef _DEBUG
#define DEBUGOUT(str); {printf(str); fflush(stdout);}
#else
#define DEBUGOUT(str);
#endif

int main (int argc, char **argv)
{
  // ./a.out num_processes elements/process filename
  int nprocs;
  int nelems;
  char *fname;
  int rank, nranks;
  int name_len;
  char name[MPI_MAX_PROCESSOR_NAME];
  int ret;
  MPI_Status status;
  double *data;
  long int disp;
  MPI_File mfh;
  double d1, d2;
  int i;

  if(argc!=4){
	printf("usage: %s num_procs elements/process filename\n", argv[0]);
	return -1;
  }
  nprocs = atoi(argv[1]);
  nelems = atoi(argv[2]);
  fname  = argv[3];

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &rank);
  MPI_Comm_size (MPI_COMM_WORLD, &nranks);
  MPI_Get_processor_name(name, &name_len);
  printf("%d/%d %s, %d elements, %d KByte, %s\n", rank, nranks, name, nelems, (nelems/1000)*8, fname); fflush(stdout);
  if(nranks!=nprocs){printf("nranks != nprocs\n"); return -1;}

  data = (double*)malloc(sizeof(double)*nelems);
  for(i=0; i<nelems; i++){
    data[i] = (double)(i%0x100) + (double)rank*0.01;
  }
  disp = sizeof(double)*nelems*rank;

  d1 = MPI_Wtime();
  DEBUGOUT("MPI_File_open\n");
  ret = MPI_File_open(MPI_COMM_WORLD, fname, MPI_MODE_RDWR|MPI_MODE_CREATE, MPI_INFO_NULL, &mfh);
  if(ret!=MPI_SUCCESS){printf("MPI_File_open failed (%s)\n", fname); MPI_Abort(MPI_COMM_WORLD, -1); return -1;}
  DEBUGOUT("MPI_File_set_view\n");
  ret = MPI_File_set_view(mfh, disp, MPI_DOUBLE, MPI_DOUBLE, "native", MPI_INFO_NULL);
  if(ret!=MPI_SUCCESS){printf("MPI_File_set_view failed\n"); MPI_Abort(MPI_COMM_WORLD, -1); return -1;}
  DEBUGOUT("MPI_File_write_all\n");
  ret = MPI_File_write_all(mfh, data, nelems, MPI_DOUBLE, &status);
  if(ret!=MPI_SUCCESS){printf("MPI_File_write_all failed\n"); MPI_Abort(MPI_COMM_WORLD, -1); return -1;}
  DEBUGOUT("MPI_File_close\n");
  ret = MPI_File_close(&mfh);
  if(ret!=MPI_SUCCESS){printf("MPI_File_close failed\n"); MPI_Abort(MPI_COMM_WORLD, -1); return -1;}
  d2 = MPI_Wtime() - d1;
  double dmin, dmax, dsum;
  MPI_Reduce(&d2, &dmin, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dmax, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
  MPI_Reduce(&d2, &dsum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  if(rank==0)printf("mpiio_singlefile_write64: min %.4f sec, max %.4f sec, avg %.4f sec\n", dmin, dmax, dsum/(double)nranks);

  free(data);
  MPI_Finalize();
  return 0;
}
