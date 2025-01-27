using Base.Threads
using SharedArrays

function my_long_running_function(i)
	sleep(1) # Waits for 1 second
    return i
end

a = 5

# Array of size 11 used to hold the individual results.
# This array is "Shared" by the threads
results = SharedArray{Int}(2*a+1)


@time begin # This counts the execution time of the block
	@threads for i in -a:a # Loop from -a to a with step 1
		results[i+a+1] = my_long_running_function(i)
	end
end;

result = sum(results)

println("Result: $(result)")

