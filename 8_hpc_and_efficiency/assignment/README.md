# Assignment 8

### Submitting a job array

In the folder `assignment`, we have a script, `buildandsolve.jl`, that creates a random network of nodes and arcs using two input parameters `randomseed` and `numnodes`, then solves a shortest path from `node=1` to `node=numnodes` just as we saw in class. 

The parameters of five networks are given in the file `experiments.csv`. 

1. Write a batch script that kicks off an array of 5 jobs, taking a parameter 1-5 and passing it to the script `buildandsolve.jl`. 
2. Modify `buildandsolve.jl` to take in the parameter 1-5 from the batch script and read the appropriate line of data from `experiments.csv`. 
3. Submit your batch script to the cluster, being sure to resolve any errors. 
 - If you’re having issues, add a output log and error log file to your batch script. You may need to add Julia packages if they aren't installed, following the same procedure from the pre-assignment. 
 - You can also test your code locally before submission using Terminal/Git Bash commands. The same `julia buildandsolve.jl 3` syntax will work to test that your argument (in this case, `3`) is being passed and used by Julia as intended. 
4. Take a screenshot of the contents of your `outputs` folder after the job completes and submit on Canvas.

### Questions
If you have any questions, email George at geomar@mit.edu. Due Saturday 2/3 at midnight! 

Remember, you only need to submit 6 out of 7 homework assignments! 
