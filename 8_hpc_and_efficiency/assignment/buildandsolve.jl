
using CSV, DataFrames, Random

runid = 1

#Get network parameters
experiments = CSV.read("experiments.csv", DataFrame)
randomseedval = experiments[runid, 2]		
numnodes = experiments[runid, 3]
Random.seed!(randomseedval)

#Build network
outputfilename = string("outputs/sp", runid, ".csv")

#-----------------------------------------------------------------------------#

#Randomly select coordinates of nodes
loccoords = zeros(numnodes, 2)
loccoords[1,:] = [0 0]
for n in 2:numnodes-1
	loccoords[n,1] = round(rand(),digits=2)
	loccoords[n,2] = round(rand(),digits=2)
end
loccoords[numnodes,:] = [1 1]

#Create arcs between nodes within a certain distance
arcstartnode, arcendnode, arccost = [], [], []
A_plus = Dict()
for n in 1:numnodes
    A_plus[n] = []
end
for n1 in 1:numnodes, n2 in setdiff(1:numnodes, n1)
	dist = sqrt((loccoords[n1,1] - loccoords[n2,1])^2 + (loccoords[n1,2] - loccoords[n2,2])^2)
	if dist < 0.3
		push!(arcstartnode, n1)
		push!(arcendnode, n2)
		push!(arccost, dist * (1 + rand()/10) )
        arcindex = length(arccost)
        push!(A_plus[n1], arcindex)
	end
end

#-----------------------------------------------------------------------------#

function findshortestpath(orig, dest)

	#Initialize shortest path algorithm (Dijkstra's)
	visitednodes = zeros(numnodes)
	currdistance = repeat([999999999.0],outer=[numnodes])
	currdistance[orig] = 0
	currnode = orig
	prevnode, prevarc = zeros(numnodes), zeros(numnodes)

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

	println("Shortest path = ", pathnodes)
	println("Shortest path cost = ", currdistance[dest])

	return currdistance[dest], pathnodes

end

#-----------------------------------------------------------------------------#

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

CSV.write(outputfilename, df)
