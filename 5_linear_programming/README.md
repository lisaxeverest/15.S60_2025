# Session 5: Introduction to Linear Optimization (Excel, Julia, Python)

In this session, we introduce some of the most commonly used software tools for solving linear optimization problems: Excel (Solver), Julia (JuMP), and Python (CVXPy). Additionally, to motivate each of these tools, we'll also cover:
1. Advanced Excel tools: Pivot Tables, Goal Seek.
2. Introduction to the Julia programming language.
3. Solving LPs using the Primal-Dual Hybrid Gradient algorithm in Python's CVXPy.


## Task 1: Enable Excel Solver
Excel's Solver is a built-in add-on tool that can solve small (up to 200 variables) linear, nonlinear, and integer optimization problems.

To enable it for **Windows**:
1. File -> Options -> Add-Ins 
2. Select Excel Add-ins from the Manage box. Click Go.
3. Select the Solver Add-in check box. Click OK.

For **Mac**, go Data -> Analysis Tools and enable Solver Add-In.

### Task 1a (optional): Install OpenSolver
OpenSolver is an open-source extension of Excel's Solver. It can automatically enter the model for you. Go to https://opensolver.org/ and follow the installation instructions if you're interested.

## Task 2: Install Julia and packages

Please download the most recent version of Julia. As of January 2025, the current stable release is v1.11.2. You can download it [here](https://julialang.org/downloads/). To open Julia, navigate to your applications folder and select the Julia 1.11 icon.
You can also open it by navigating to a terminal and typing "julia".


(Note: even if you have Julia>=1.9.0 installed, it's good practice to update to the latest version of Julia, and it's easy to do so with `juliaup`, the Julia version manager! `juliaup` allows you to maintain separate Julia installations and we highly recommend it.)

### Julia packages

We will be running a few Jupyter notebooks in this session. IJulia basically hijacks Python's Jupyter notebook, allowing us to run Julia code in line with text, math, and visualizations. You can add IJulia by running the following commands in a Julia session.
```
julia> using Pkg
julia> Pkg.add("IJulia")
```
The package manager provides a less verbose installation alternative.
```
julia> ]
(@v1.10) pkg> add IJulia
```
You can exit the package manager by pressing delete/backspace.

While you're there, please install the following packages:
* DataFrames
* JuMP
* CSV
* Plots
* Random
* LinearAlgebra
* Printf
* PyCall

### (Advanced) Set up a project enviroment

Navigate to this folder, start Julia, and run the following:
```
julia> activate .
```
You should see something like `Activating new project at [YOUR_DIRECTORY_HERE]/15.S60_2024/5_linear_programming`. Then, install the packages like you did before:
```
(5_linear_programming) pkg> add DataFrames, JuMP, CSV, Plots, Random, LinearAlgebra, Printf
```

More information on using separate Julia environments for each project can be found [here](https://pkgdocs.julialang.org/v1/environments/).

## Task 3: Install Gurobi

Gurobi is a commercial solver with free academic licenses. They are a pain in the booty to install, but Gurobi is quite powerful and worth the hassle! Please follow these steps to get the software onto your computer.

1. Go to [Gurobi's website](https://www.gurobi.com/) and sign up for a free account.
2. The downloads page is [here](https://www.gurobi.com/downloads/gurobi-optimizer-eula/). Accept the license agreement and download the most recent version of the Gurobi optimizer (v1.11.2). Follow the installation instructions as prompted.
3. You will need an MIT IP address for step 4. If you are off campus, you can use the [MIT VPN](https://ist.mit.edu/vpn) to connect to the network. (I would recommend only trying this after step 4 fails to work for you.)
4. After you have downloaded the optimizer software, you must obtain an Academic license. The license eventually expires, so you will have to repeat these steps every so often. (Julia will notify you when your Gurobi license is about to expire or if it has already expired--you won't be able to solve your models until it has been renewed.) Navigate [here](https://www.gurobi.com/downloads/end-user-license-agreement-academic/) and accept the conditions. Scroll to the bottom of the page and you should see something like this:
```
grbgetkey xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```
Copy the command (not this one--the one at the bottom of your page with your actual license key!) and paste it into a terminal (not a Julia REPL). Follow the default installation instructions as prompted. Now your computer is allowed to use Gurobi.

5.  Install the Gurobi wrapper in Julia. Before adding Gurobi to our Julia environment, we must point the wrapper to the location of the Gurobi Optimizer's installation. Open a Julia REPL and type the following. If you are on a Mac:
```
julia> ENV["GUROBI_HOME"] = "/Library/gurobi1100/macos_universal2/"
```
Windows:
```
julia> ENV["GUROBI_HOME"] = "C:\\Program Files\\gurobi1100\\win64\\"
```
Linux/Unix:
```
ENV["GUROBI_HOME"] = "/opt/gurobi1100/linux64/"
```
Now, regardless of operating system, run the following commands.
```
julia> using Pkg
julia> Pkg.add("Gurobi")
julia> Pkg.build("Gurobi")
```
A very common error is that the GUROBI_HOME parameter is not properly configured. Feel free to reach out with any difficulties/questions.

If you encounter many obstacles, you can also install the package `GLPK`. This optimizer is not as powerful but does not require the installation of other software.

## Task 4: Install CVXPY in Python

In addition to Julia, we will also briefly introduce an alternative way to solve optimization problems in Python. Please install the following packages in Python. 
```
python> !pip install cvxpy
python> !pip install numpy
python> !pip install gurobipy
python> !pip install ortools==9.7.2996
```

## Preassignment (due Jan 20, 2025, 11:59pm EST)
1. Excel: Click on Solver. On Canvas, submit a screenshot of the Solver Parameters popup window.

2. Julia: To ensure your installation environment works, please do the following: In a terminal, open Julia. Then run the following commands.
```
julia> using IJulia
julia> notebook()
```
Create a new notebook by selecting New > Julia 1.11.2. Run the following command in a cell:
```
using CSV, DataFrames, JuMP, Gurobi, LinearAlgebra, Plots, Random, Printf
```
The installation is successful if the cell does not return any errors (warnings are ok). On Canvas, submit a screenshot of the full web browser page depicting the notebook outputs and the Julia kernel in use.

## Questions?
Email Karl Zhu (karlzhu@mit.edu) for any installation questions. It's possible that the instructions are outdated and no longer work.
