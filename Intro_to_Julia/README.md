# Intro to Julia

Josquin Guerber  <josquin.guerber@mnhn.fr >
Isabelle Gounand <isabelle.gounand@sorbonne-universite.fr>

February 14, 2024


Files provided in this folder include:

-  the pluto notebook that we presented, which wraps up what we presented in the jupyter notebooks and more. This pluto notebook is in two formats:
   - the compiled output in html format **Intro_julia.html**
   - the source julia file **Intro_julia.jl** that you can view in a text editor or run with pluto by installing the Pluto package in a Julia console (`using Pkg; Pkg.add("Pluto")`) and run it by typing in the julia console `import Pluto; Pluto.run()` ; then Pluto opens in your internet navigator and you open the file via its browser.
   - there are two images called when running this pluto notebook: *JuliaLogo.png* and *julia_prompt.png*
   
- the Jupyter notebooks that you can run in Jupyter lab:
    - **basics.ipynb**: basic concepts presented by Josquin
    - **simple_model.ipynb**: simple examples of numerical integration for a Lotka Volterra 2-species and multispecies models. For this second notebook we show how to upload files with an example file containing a matrix: **interaction_mat.txt**
