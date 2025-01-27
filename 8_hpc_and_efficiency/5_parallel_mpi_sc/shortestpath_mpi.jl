
using CSV, DataFrames, MPI

include("scripts/spfunction.jl")

#Initialize MPI 
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
nproc = MPI.Comm_size(comm)

runs = 1:50
outputfile = "outputs/paralleloutput.csv"

#Select the runs for this particular rank (cycling, like dealing cards)
myrun_list = runs[rank+1:nproc:length(runs)]

#Initialize time 
inittime = time()

println("Hello, World! I am rank $rank of $nproc processors, running $myrun_list.\n")

#Run the runids that were dealt to this rank!
mynumnodes_list, myspcost_list, myelapsedtime_list = [], [], []
for runid in myrun_list

	#Get the input file for the runid
	networkfile = string("data/network", runid, ".csv")

	#Read data
	data = CSV.read(networkfile, DataFrame)

	#Format node data
	nodes = []
	for i in 1:size(data)[1]
		push!(nodes, data[i,2])
		push!(nodes, data[i,3])
	end
	nodes = unique!(nodes)
	numnodes = length(nodes)

	#Format arc data 
	arcs, arcendnode, arccost = [], [], []
	A_plus = Dict()
	for n in nodes
		A_plus[n] = []
	end
	for i in 1:size(data)[1]
		push!(arcs, data[i,1])
		push!(arcendnode, data[i,3])
		push!(arccost, data[i,4])
		push!(A_plus[data[i,2]], data[i,1])
	end
	numarcs = length(arcs)

	orig = 1
	dest = numnodes

	#Solve shortest path
	begintime = time()
	spcost, spnodes= findshortestpath(orig, dest, numnodes, A_plus, arcendnode, arccost)
	endtime = time()
	elapsedtime = endtime - begintime

	#Save the relevant runid data
	push!(mynumnodes_list, numnodes)
	push!(myspcost_list, spcost)
	push!(myelapsedtime_list, elapsedtime)

end

#---------------------------------------------------------------------------------------#

#Ranks communicate to gather and reformat all data
if rank > 0
	
	#Send your data to rank 0
	println("$rank: Sending data $rank -> 0\n")
	mydata = hcat(myrun_list, mynumnodes_list, myspcost_list, myelapsedtime_list)
	MPI.send(mydata, 0, rank+nproc, comm)

elseif rank == 0

	#Get everyone's data
	allruns = Dict()
	allruns[1] = hcat(myrun_list, mynumnodes_list, myspcost_list, myelapsedtime_list)
	for i in 1:nproc-1
		allruns[i+1], statrcv = MPI.recv(i, i+nproc, comm) 
	end

	#Use merge to get overall data
	alldata = reduce(vcat, (allruns[i] for i in 1:nproc))

	#Write a single file with all data
	df = (runid = alldata[:,1], 
		numnodes = alldata[:,2],
		cost = alldata[:,3],
		solvetime = alldata[:,4]
		)

	CSV.write(outputfile, df)

end
