
using CSV, DataFrames

runid = 1

networkfile = string("data/network", runid, ".csv")
outputfile = string("outputs/network", runid, ".csv")

data = CSV.read(networkfile, DataFrame)

nodes = []
for i in 1:size(data)[1]
	push!(nodes, data[i,2])
	push!(nodes, data[i,3])
end
nodes = unique!(nodes)
numnodes = length(nodes)

arcs, arcstartnode, arcendnode = [], [], []
arccost = []
A_plus = Dict()
for n in nodes
	A_plus[n] = []
end
for i in 1:size(data)[1]
	push!(arcs, data[i,1])
	push!(arcstartnode, data[i,2])
	push!(arcendnode, data[i,3])
	push!(arccost, data[i,4])
	push!(A_plus[data[i,2]], data[i,1])
end
numarcs = length(arcs)

inittime = time()

function findshortestpath(orig, dest)

	#Initialize shortest path algorithm (Dijkstra's)
	visitednodes = zeros(numnodes)
	currdistance = repeat([999999999.0],outer=[numnodes])
	currdistance[orig] = 0
	currnode = orig
	prevnode, prevarc = zeros(numnodes), zeros(numnodes)
	nopathexistsflag = 0
	algorithmstopflag = 0

	#Find shortest path from origin to destination
	while true

		#Assess all neighbors of current node
		for a in A_plus[currnode]
			n = arcendnode[a]
			if visitednodes[n] == 0
				newdist = currdistance[currnode] + arccost[a]
				if newdist < currdistance[n] + 1e-4
					currdistance[n] = newdist
					prevnode[n] = currnode
					prevarc[n] = a
				end
			end
		end

		#Mark the current node as visited
		visitednodes[currnode] = 1
		currdistance_unvisited = [if visitednodes[n] == 0 currdistance[n] else 999999999 end for n in 1:numnodes]
		currnode = argmin(currdistance_unvisited)

		#Termination criterion
		if minimum(currdistance_unvisited) == 999999999
			break
		end

	end

	#Format the shortest path output
	patharcs, pathnodes = [], [dest]
	nd = dest
	while nd != orig
		pushfirst!(patharcs, Int(prevarc[nd]))
		nd = Int(prevnode[nd])
		pushfirst!(pathnodes, nd)
	end

	#println("Shortest path = ", pathnodes)
	#println("Shortest path cost = ", currdistance[dest])

	return currdistance[dest], pathnodes

end

#---------------------------------------------------------------------------------------#

orig = 1
dest = numnodes

begintime = time()
spcost, spnodes= findshortestpath(orig, dest)
endtime = time()
elapsedtime = endtime - begintime

#---------------------------------------------------------------------------------------#

df = (runid = [runid], 
	numnodes = [numnodes],
	cost = [spcost],
	solvetime = [elapsedtime]
	)

CSV.write(outputfile, df)

#---------------------------------------------------------------------------------------#
