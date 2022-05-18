## Calling Cpp functions from R

1. Create a new project
2. Choose "R package using Rcpp"
3. Create and save your .cpp functions in the `src` folder
4. In the `DESCRIPTION` file,  add `RcppEigen` after `Rcpp` in the last line
5. Run `More > Clean and Rebuild`

! Do not name your package `Rcpp` ;)