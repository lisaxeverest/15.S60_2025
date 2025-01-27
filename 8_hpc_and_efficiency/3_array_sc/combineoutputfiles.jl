
using CSV, DataFrames

figuredirectory = string("outputs")

#Get list of files
filelist = readdir(figuredirectory)
combofile = string(figuredirectory, "/combined.csv")

#Combine files and save to combofile
for file in filelist
	println("Adding ", file)

	#Add all rows (including header) from first file
	if file == filelist[1]
		open(string(figuredirectory, "/", file)) do input
		    open(combofile, "a") do output
		        for line in eachline(input)
			        println(output, line)
		        end
		    end
		end
	#Drop header row from other files
	else
		open(string(figuredirectory, "/", file)) do input
		    open(combofile, "a") do output
		        for line in Iterators.drop(eachline(input), 1)
		            println(output, line)
		        end
		    end
		end
	end
end
