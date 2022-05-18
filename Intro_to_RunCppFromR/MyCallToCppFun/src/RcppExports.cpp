// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppEigen.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// inverse
Rcpp::List inverse(const Eigen::MatrixXf& inputMatrix);
RcppExport SEXP _MyCallToCppFun_inverse(SEXP inputMatrixSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Eigen::MatrixXf& >::type inputMatrix(inputMatrixSEXP);
    rcpp_result_gen = Rcpp::wrap(inverse(inputMatrix));
    return rcpp_result_gen;
END_RCPP
}
// meanCPPhand
Rcpp::List meanCPPhand(const Eigen::VectorXf& inputVector);
RcppExport SEXP _MyCallToCppFun_meanCPPhand(SEXP inputVectorSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Eigen::VectorXf& >::type inputVector(inputVectorSEXP);
    rcpp_result_gen = Rcpp::wrap(meanCPPhand(inputVector));
    return rcpp_result_gen;
END_RCPP
}
// meanCPP
Rcpp::List meanCPP(const Eigen::VectorXf& inputVector);
RcppExport SEXP _MyCallToCppFun_meanCPP(SEXP inputVectorSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Eigen::VectorXf& >::type inputVector(inputVectorSEXP);
    rcpp_result_gen = Rcpp::wrap(meanCPP(inputVector));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_MyCallToCppFun_inverse", (DL_FUNC) &_MyCallToCppFun_inverse, 1},
    {"_MyCallToCppFun_meanCPPhand", (DL_FUNC) &_MyCallToCppFun_meanCPPhand, 1},
    {"_MyCallToCppFun_meanCPP", (DL_FUNC) &_MyCallToCppFun_meanCPP, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_MyCallToCppFun(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
