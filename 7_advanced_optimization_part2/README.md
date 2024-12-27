# Pre-assignment

*Note.* Any Julia version >= 1.7 is fine.

0. Please have `Gurobi` installed. If not, please install it following the instructions for the previous session.

1. Now we install `Mosek`, which is a commercial solver for solving conic convex optimization:
   * Go to https://www.mosek.com/downloads/, scroll to *Default Installers (Preferred)*, then download and install the version based on your operating system.
   
   * After that we need to get an academic license for using it. Go to https://www.mosek.com/license/request/?i=acp  and using your MIT email address, request an academic license. `Mosek` will email you (usually within minutes) the license file with instructions on how to install it. Install the license accordingly.
  
2. Next, we install the necessary `Julia` packages:
   
   * Open `Julia` REPL. Press `]` to enter package installation mode and input the following: 
     `add MosekTools, Mosek, Convex, JuMP, Ipopt, Images, DelimitedFiles, Gadfly, CSV`
   
     which besides `Mosek` installs some other packages that we will use. This includes installation of the nonlinear solver `Ipopt`.
     
3.  To confirm proper installation and licensing of all packages, run the preassignment notebook.  If everything is working properly, all cells should run without generating any output.

If you have any issue during the installation phase, please contact `brunm@mit.edu`. **Please note that although it is a pre-assignment, you do not need to submit anything on Canvas and completion will not be graded.**
