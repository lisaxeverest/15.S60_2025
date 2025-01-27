
using MPI

#Initialize environment
MPI.Init()

#Get MPI process rank
rank = MPI.Comm_rank(MPI.COMM_WORLD)

#Get number of MPI processes in this communicator
nproc = MPI.Comm_size(MPI.COMM_WORLD)

println("Hello, World! I am rank $rank of $nproc processors.\n")
