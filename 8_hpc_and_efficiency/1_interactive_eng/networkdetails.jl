
using CSV, DataFrames

data = CSV.read("network.csv", DataFrame)

nodelist = []
for i in 1:size(data)[1]
	push!(nodelist, data[i,2])
	push!(nodelist, data[i,3])
end
nodelist = unique!(nodelist)

println("Network details:")
println("Num nodes = ", length(nodelist))
println("Num arcs = ", size(data)[1])