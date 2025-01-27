using Base.Threads

function my_long_running_function(i)
	sleep(1) # Waits for 1 second
    return i
end

result = 0
a = 5

@time begin # This counts the execution time of the block
	@threads for i in -a:a # Loop from -a to a with step 1
		global result = result + my_long_running_function(i)
	end
end;

println("Result: $(result)")

