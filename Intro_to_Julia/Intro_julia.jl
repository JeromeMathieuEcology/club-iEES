### A Pluto.jl notebook ###
# v0.19.38

#> [frontmatter]
#> title = "Club Method iEES-Paris:                Intro to Julia"
#> date = "2024-02-14"
#> 
#>     [[frontmatter.author]]
#>     name = "Josquin Guerber"
#>     [[frontmatter.author]]
#>     name = "Isabelle Gounand"

using Markdown
using InteractiveUtils

# ╔═╡ 7add294e-38f1-49b2-84ff-29bd7110b513
begin
	using PlutoUI
end

# ╔═╡ 392c7f16-c051-11ee-1179-db9e208bb42c
html"<button onclick='present()'>present</button>"

# ╔═╡ 1cce66d4-6b64-4ae1-94fd-cb2502335cb7
md"
# Club Methodo iEES: Intro to Julia

"

# ╔═╡ 885114d1-8117-4f6d-8ca8-7761ae5d93e3
begin
	PlutoUI.LocalResource("./JuliaLogo.png")
end

# ╔═╡ 9b0e7596-3759-4119-8c27-22401b746fb8
html"
<h4>Josquin Guerber and Isabelle Gounand<h4>


2024-02-14

"

# ╔═╡ ca7aae93-3675-4bad-92ff-98d67ee5e04e
md"
#    Plan
- General features
- How to install and work with Julia
- Basics
  1. Variables and types
  1. Data structures
  1. Loops and flow controls
  1. Functions
  1. Miscellanous
- Data manipulation
  1. Creating arrays
  2. Using arrays
- Example with a simple dynamical model
  1. Numerical Integration
  1. Callbacks
  1. Inputs / Outputs
  1. Miscellanous for codes
- Useful modules
"

# ╔═╡ 85e864a5-86c9-471a-b90d-47ca0c5d9540
md"
#    General Features

> See an introduction  [https://docs.julialang.org/en/v1/#man-introduction](https://docs.julialang.org/en/v1/#man-introduction)
> and [https://docs.julialang.org/en/v1/#man-julia-compared-other-languages](https://docs.julialang.org/en/v1/#man-julia-compared-other-languages)

- It is a programming language
- Created for dynamical systems in 2010 MIT
- Fast (~ C)
- User friendly: the best of R, Python, Matlab 
- Dynamical community: 
  - Developpers very reactive
  - Documentation: [https://julialang.org/](https://julialang.org/)
  - Tutorials: [https://julialang.org/learning/](https://julialang.org/learning/)
  - But deprecations



	"

# ╔═╡ bec4096e-3d83-4d08-b40f-2724ba846447
md"
#    How to work with Julia (1)

- Installation procedure: 
> Download here: [https://julialang.org/downloads/](https://julialang.org/downloads/) 

You get a Command Line interface that interprets Julia (aka REPL - Read Eval Print Loop):
"

# ╔═╡ 2f0c97d6-cb2b-4397-bbd0-562021ffbf86
begin
	PlutoUI.LocalResource("./julia_prompt.png")
end

# ╔═╡ 4a5e832a-5d16-4f72-9f7e-af7f37ff3c30
md"
- Call it in a terminal (unix) or Prompt (windows) with command:
```
> julia
```

- And quit julia with command: 
```
> exit()
```
"

# ╔═╡ 30921a43-83a9-4c70-ac2d-dd849b6145d7
md"
#    How to work with Julia (2)

Make scripts in text editors saved as Julia executable files my_file.jl and run in Julia REPL:

```
> script.jl arg1 arg2...
```

**For a more user-friendly Integrated Development Environment**:

see [tutorial for installing](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/getting-started)

- **Jupyter Lab** (can make Jupyter Notebooks.ipynb)
  1. Install Julia and Anaconda 
  2. Install and launch module `IJulia` in `Julia` to have Julia kernel in Jupyter
  2. Launch Jupyter from Anaconda

```
> using Pkg; Pkg.update();Pkg.add(\"IJulia\") 
```

- **Visual Studio Code** with extensions for Julia

- **Pluto** (easy notebooks)
  1. Install `Pluto.jl`module in `Julia`
  2. Launch the package from julia REML

```
> using Pkg; Pkg.update();Pkg.add(\"Pluto\")
```

```
> import Pluto; Pluto.run()
```


"

# ╔═╡ 16dade94-cb2c-43d9-af5b-2ec0079038ce
md"
# Basics 

  1. Variables and types
  1. Data structures
  1. Loops and flow controls
  1. Functions
  1. Miscellanous

**Let's look at `basics.ipynb` jupyter notebook**

"


# ╔═╡ ce46635c-1d30-43d5-b32a-e40768488b4b
md"
## Basics 1\. Variables and types
- Assignation with operator `\"=\"`
- Know the type: `typeof(a)`
- Usual types:
  - Integers `Int64`
  - Floats `Float64`
  - Strings `String`
  - Booleans `Bool`
  - Numeric `Number` 
- Compare to types: `a isa String`
- Convert in a type: `convert(Float64,a)`
- Forbidden keywords:
> baremodule, begin, break, catch, const, continue, do, else, elseif, end, export, false, finally, for, function, global, if, import, let, local, macro, module, quote, return, struct, true, try, using, while
"

# ╔═╡ d989e32d-04c0-4f7f-8cde-295228379734
md"
## Basics 2\. Data structure
- **Arrays and Mutlidimensional arrays**: `A = [1 2 3 ; 4 5 6 ; 6 7 8]`
  - Ordered
  - Mutable
  - Access with squared brackets, positions from 1: `A[:,1]`


- **Tuples and NamedTuples**: `new_tuple = (1,2,3,4)`, `named_tuple = (a = 2, b = 4, c = 6)`
  - Ordered
  - Not mutable
  - Access with squared brackets, positions from 1


- **Dictionaries**: `mydict = Dict(\"name_el1\" => (3,4), \"name_el2\" => (\"gizmo\"))`
  - Non ordered 
  - Mutable
  - Access with squared brackets with name of the element: `named_tuple[:c]`

All can be composed of elements of one or different types

Elements can be of different lengths

"

# ╔═╡ 0714f08a-0fcd-4df6-9e5d-1408507b422b
md"
## Basics 3\. Loops and flow control (1)

**Condition blocks**

with **if**
```
> if \"test\" isa String
>   result = 5
> else
>   result = 3
> end
```

with **ternary operator**
```
> result = (\"test\" isa String) ? 5 : 3
```
Equilvalent to `ifelse` in R

with **`elseif`** for additional conditions

```
> if *condition 1*
>     *option 1*
> elseif *condition 2*
>     *option 2*
> else
>     *option 3*
> end
```

**Boolean operators**

AND and OR boolean operations in julia use `&&`and `||` respectively. 

Single symbols are for bitwise AND and OR.
"

# ╔═╡ e8dcd0af-e782-4c8a-ad25-0e3c35c58639

md"
## Basics 3\. Loops and flow control (2)

**`while` loop**
```
> count = 0
> while count <= 5
>     count += 1
> end
```

**`for` loop**
```
> for n in 1:10
>     println(n)
> end
```

Compact nested for loops, here to fill a matrix
```
> for i in 1:m, j in 1:n
>     B[i, j] = i + j
> end
```

Array comprehension, a synthetic julia way to do the same:
```
> B = [i + j for i in 1:m, j in 1:n]
```

"

# ╔═╡ 1c382a6e-9500-4415-8953-948e1a46baf3
md"
## Basics 4\. Functions

**Declarations**

Short functions
```
> f2(x) = x^2
```
Anonymous functions (to pass as argument in another function)
```
> f3 = x -> x^2
```

Longer ones

```
> function is_even(x)
>     modulo = x % 2
>     return (modulo == 0)
> end
```

**Multiple dispatch**

One function with several methods → different types or numbers of arguments

```
> function is_even(x::String)
>     return(\"An even String makes no sense !\")
> end
```

```
> function compare(x::Number, y::Number)
>     println(x < y ? \"$x smaller than $y\" : \"$x greater than $y\")
> end

> function compare(x, y, z)
>     compare(x,y)
>     compare(y,z)
>     compare(x,z)
> end
```

To know the methods associated with a generic function
```
> methods(compare)
```
**Mutating functions** 

Convention to say an entry argument is modified: name terminated by “!”

```
> sort!(vec)
```


"

# ╔═╡ 331ecd53-237d-4882-9f54-b80556d9aeae
md"
## Basics 5\. Miscellanous
- **Install and use modules** (also called packages or libraries)
```
> using Pkg
> Pkg.add(\"Plots\")
> using Plots
```

- **Macros**: user-friendly wrappers for some Julia functions
   - provide benchmark statistics: `@time randn(150000)` 
   - print to console: `@info \"Hello there !\"`
   - get help: `@doc println`
```
> @macro_name thing_to_evaluate
```



"

# ╔═╡ 817fd7f9-1282-40e5-b809-7935e4ea199a
md"
# Data Manipulation 
Data Manipulation 1\. Creating arrays
-------------------------------------

- **Empty objects**: have to define type
```
> myarray = Array{Int64,2}              # A matrix og integers
> myarray = Float64[]                   # A vector of decimal numbers 
> myarray = Vector{Vector{Float64}}()   # a vector of vectors
```

- **Known initial values**
```
> vec = [0.4, 0.67, 1.2]   # a vector: numbers separated with spaces
> A = [1 2 ; 3 4 ; 5 6]  # a matrix each row separated with \";\")
> B = [1 2 3]            # a row matrix
> C = [1 2 3]’           # a column matrix
```

- **Initialize with a given value**
```
> x = zeros(5)           # 5-element vector of 0.0
> A = zeros(2,2)         # 2x2 matrix of 0.0
> A = zeros(2,2)         # 2x2 matrix of 1.0
> A = fill(100, (m, n))  # mxn matrix of intergers filled with 100
```

- **Initialize with random values**
```
> A = rand(2,2)         # Fill with numbers between 0 and 1
> A = randn(2,2)        # Fill with numbers from normal distribution 
```

- **Sequences of values**
```
> seq1 = j:k:n                    # Sequence of Int from j to n with stepsize k  
> seq2 = range(1, 5,length = 6)   # Sequence of 6 elements from 1 to 5
```

"

# ╔═╡ 21bc70ce-971a-418b-9724-d053b9d4dca9
md"
## Data Manipulation 2\. using arrays (1)

- **Access elements**

```
> A[2,1]		# a specific element
> A[1:4,:]		# specific rows
> A[:,1:3]		# specific columns
```

- **Objects' size**
```
> length(A)       # object's number of elements
> size(A)         # number of elements in each dimension
```

- **Add and remove elements**
```
> array = [2,3,4,5]       # Define an array
> push!(array, 45 / 5)    # Add an element atthe end of the array
> pop!(array)             # Remove the last element
```

- **Repeat**
```
> repeat(“hi”,3)             # repeat 3 times hi; is equivalent to `“hi”^3`
> repeat([1,3],inner = 2)    # repeat each element 2 times
> repeat([1,3],outer = 2)    # repeat 2 times the vector
```

- **bind**

```
> A = [[1 6] [4 2]]   or  A = hcat([1 6], [4 2])    # bind horizontally (cbind in R)
> A = [[1 6] ; [4 2]] or  A = vcat([1 6], [4 2])    # bind vertically (rbind in R)
```

"

# ╔═╡ bd47412b-68f1-404f-81d5-10917c10edf5
md"
## Data Manipulation 2\. using arrays (2)


- **Vectorize and broadcast**
Julia operators are not \"vectorizing\" operations when variables doesn't have the same dimension.
To apply an operator to each element of an array, we need to use the dot \".\"

```
> [2, 7, 9, 11] + 12           # Doesn't work!
> [2, 7, 9, 11] .+ 12          # This works

```

We have also the functions `map`or `broadcast`; here with `broadcast`:

```
> f = x -> x^3
> broadcast(f, [1, 2, 3])
```
equivalent to
```
> broadcast(x -> x^3, [1, 2, 3])
```
equivalent to
```
> f.([1, 2, 3])
```


NB: For the differences between `map` and `broadcast` see [here](https://stackoverflow.com/questions/52892726/julia-whats-the-difference-between-map-and-broadcast)

"

# ╔═╡ f9aea24f-10c5-4d2d-85b9-b6a1a44d8d2e
md"
# Example of simple dynamical model

Model 1\. Numerical integration 
----------------------------------

> Video tutorials [here](https://www.youtube.com/watch?v=KPEqYtEd-zY) and [here](https://www.youtube.com/watch?v=zJ3R6vOhibA)

- **Module**: `DifferentialEquations`
- **Definition of the derivative function**
```
> function foo!(du, u, p, t)              
>     r0, AA = p                           #--- unpack parameters
>     du .= u .* (r0 .+ (AA * u))          #--- equations
> end
```
where *`du`*, *`u`*, and *`t`*  are the vectors of derivatives, densities of state variables, and time, and *`p`* is the list of parameters. 

- **Definition of the numerical problem**

```
> prob = ODEProblem(foo!, u0, tspan, p)
```
where *`foo!`*, is the function of derivatives, *`u0`* the initial densities, and *`tspan`* the tuple of tmin and tmax, and *`p`* is the list of parameters. 

- **Running the numerical integration**
```
> sol = solve(prob)
```
with interesting possible arguments
```
> sol = solve(prob,KenCarp4())             #--- specify the methods
> sol = solve(prob,saveat = 1:tspan[2])    #--- specify times to save the dynamics

# specify negative densities are unfeasible 
> sol = solve(prob,isoutofdomain = (u, p, t) -> any(x -> x < 0, u)) 
```
Other useful arguments: *`dt`*, *`abstol`*, and *`reltol`* to specify time step, and absolute and relative tolerance for integration error
"

# ╔═╡ c1aa349f-d95d-46b9-8ea1-030ddc5a7c6a
md"
## Model 2\. Callbacks
- **Module**: `DiffEqCallbacks`
- A **Callback** is a mean to access integration interface during integration. Is works with two functions, a *`condition`* and an *`affect`* function
- **Example of Discrete callbacks**
-- *`condition`* function:  it checks whether the condition is true every step
```
> function condition_stop(u, t, integrator) 
>   any(u .> 1e10)                         #--- if a density exceed 1e10
> end
```
Note that for continuous callbacks you have to provide a function that equals zero when the condition is met

-- *`affect`* function:  it says what have to be done if the condition is met
```
> function affect_stop!(integrator) 
>     terminate!(integrator)                #--- stop the integration process
> end
```
- **Define the callback**
```
> stop_cb = DiscreteCallback(condition_stop,affect_stop!)
```

- **Pass the function** to the problem definition function or *`solve`*:
```
> sol = solve(prob,callback = stop_cb)
```
- **Multiple callbacks**
```
> cb = CallbackSet(perturb_cb,extinct_cb,stop_cb)
```
"

# ╔═╡ ced24a46-e57e-4c57-b2d0-92a50c94fcad
md"
## Model 3\. Inputs / Outputs
- **Module**: `DelimitedFiles`
- **Load and write a txt file** of with tabs as separators from working directory
```
> A = readdlm(\"./interaction_mat.txt\") 
> writedlm(\"./times.txt\",sol.t)
```

- **Write in a file at multiple steps**
```
> file = open(\"./mat.txt\",\"a\")
> for i in 1:10
>   writedlm(file,i)
> end
> close(file)
```

- **Save outputs in a new directory** 
```
> simname = string(\"mysim\")                 #--- name of the current simulation
> path = joinpath(\"./\",simname)             #--- path from working folder 
> mkpath(path)                              #--- create path if not already existing
> writedlm(joinpath(path,\"times.txt\"),sol.t) #--- save file in the folder
```


"

# ╔═╡ 8d4cf450-1fa3-41e4-9cf1-a0ff4ef9b0e2
md"
## Model 4\. Miscellanous for simulation codes

- **Include your necessary modules** at the start
```
> using StatsBase, Plots
```

- **Load a separate julia file**
```
> include(\"functions.jl\")
```

- **Comment a script**
```
> # to comment on a line
> #= to comment a block
> for n in 1:10
>     println(n)
> end
> =#
```
- **Separate two commands** on the same line: use \"`;`\"

- **Set a seed** if you use random numbers 
```
> using Random
> seed = 2
> Random.seed!(seed);
```

- **`copy`**: arrays are defined with pointers (addresses); use `copy` to let the original array unchanged:
```
> a = [1, 2, 3]
> b = a           # a will change if b is modified
> b = copy(a)     # a will stay unchanged when b is modified
```

- **Precision**
Julia works with machine precision and does not correct it by rounding. So floats can display strange decimal number. Keep in mind that this expression returns “false”:
```
> 3/10 == 3 * 0.1
```
More info here [https://0.30000000000000004.com/](https://0.30000000000000004.com/) and here [https://discourse.julialang.org/t/working-with-machine-precision/29576/9 ](https://discourse.julialang.org/t/working-with-machine-precision/29576/9 )
"

# ╔═╡ 519851e5-073d-40a2-8231-67eaa74c82be
md"
# Useful modules
> [https://julialang.org/packages/](https://julialang.org/packages/)

> [https://juliapackages.com/packages](https://juliapackages.com/packages)

- Numerical integration
  - [`DifferentialEquations`](https://docs.sciml.ai/DiffEqDocs/stable/)
  - [`DiffEqCallbacks`](https://docs.sciml.ai/DiffEqCallbacks/stable/)
- Maths and statistics
  - [`LinearAlgebra`](https://juliapackages.com/p/linearalgebra)
  - [`Distributions`](https://juliapackages.com/p/distributions)
  - `Random`
  - `StatsBase`
  - `LinearRegression`
- Graphics
  - [`Plots`](https://docs.juliaplots.org/latest/tutorial/)
  - `Plotly` 
- Files and tables
  - `DelimitedFiles`
  - `TypedTables`


**Interfaces with other languages**
- Info [here](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/interfacing-julia-with-other-languages)
- Adding code with other languages into Julia
  - C:      `Libdl`
  - Python: `PyCall`
  - R:      `RCall`
- Using Julia into R code: R-package `JuliaCall`, see also [https://stateofther.github.io/finistR2018/atelier2_julia.html](https://stateofther.github.io/finistR2018/atelier2_julia.html)

"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.55"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "f64cdffc70331b0a2f407efefd54fd84eb680773"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─392c7f16-c051-11ee-1179-db9e208bb42c
# ╟─1cce66d4-6b64-4ae1-94fd-cb2502335cb7
# ╟─7add294e-38f1-49b2-84ff-29bd7110b513
# ╟─885114d1-8117-4f6d-8ca8-7761ae5d93e3
# ╟─9b0e7596-3759-4119-8c27-22401b746fb8
# ╟─ca7aae93-3675-4bad-92ff-98d67ee5e04e
# ╟─85e864a5-86c9-471a-b90d-47ca0c5d9540
# ╟─bec4096e-3d83-4d08-b40f-2724ba846447
# ╟─2f0c97d6-cb2b-4397-bbd0-562021ffbf86
# ╟─4a5e832a-5d16-4f72-9f7e-af7f37ff3c30
# ╟─30921a43-83a9-4c70-ac2d-dd849b6145d7
# ╟─16dade94-cb2c-43d9-af5b-2ec0079038ce
# ╟─ce46635c-1d30-43d5-b32a-e40768488b4b
# ╟─d989e32d-04c0-4f7f-8cde-295228379734
# ╠═0714f08a-0fcd-4df6-9e5d-1408507b422b
# ╟─e8dcd0af-e782-4c8a-ad25-0e3c35c58639
# ╟─1c382a6e-9500-4415-8953-948e1a46baf3
# ╟─331ecd53-237d-4882-9f54-b80556d9aeae
# ╟─817fd7f9-1282-40e5-b809-7935e4ea199a
# ╟─21bc70ce-971a-418b-9724-d053b9d4dca9
# ╟─bd47412b-68f1-404f-81d5-10917c10edf5
# ╟─f9aea24f-10c5-4d2d-85b9-b6a1a44d8d2e
# ╟─c1aa349f-d95d-46b9-8ea1-030ddc5a7c6a
# ╟─ced24a46-e57e-4c57-b2d0-92a50c94fcad
# ╟─8d4cf450-1fa3-41e4-9cf1-a0ff4ef9b0e2
# ╟─519851e5-073d-40a2-8231-67eaa74c82be
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
