#include <RcppEigen.h>
#include <Rcpp.h>
#include <random>

//using namespace Eigen;
using namespace std;
using namespace Rcpp;

// [[Rcpp::export]]
Rcpp::List inverse(const Eigen::MatrixXf & inputMatrix){
    Eigen::MatrixXf selectionMatrixInverse=inputMatrix.inverse();
    return Rcpp::List::create(Rcpp::Named("MatrixInverse")=selectionMatrixInverse);
}

// [[Rcpp::export]]
Rcpp::List meanCPPhand(const Eigen::VectorXf & inputVector){
    double mean=inputVector.sum()/inputVector.size();
    return Rcpp::List::create(Rcpp::Named("meancpp")=mean);
}

// [[Rcpp::export]]
Rcpp::List meanCPP(const Eigen::VectorXf & inputVector){
    double mean=inputVector.mean();
    return Rcpp::List::create(Rcpp::Named("meancpp")=mean);
}

// // [[Rcpp::export]]
// Rcpp::List multivariateNormal(const Eigen::MatrixXf & covMatrix,const Eigen::VectorXf & meanVec,const int n){
//     
//     
//     Eigen::SelfAdjointEigenSolver<Eigen::MatrixXf> eigensolver(covMatrix);
//     Eigen::MatrixXf eigenValuesMat= eigensolver.eigenvalues().array().sqrt().replicate(1,meanVec.size());
//     Eigen::MatrixXf Rgener=Eigen::MatrixXf::Zero(n,meanVec.size());
// 
// for (int i=0;i<n;++i){
//     for (int j=0;j<meanVec.size();++j){
//         Rgener(i,j)= normsample(generator);
//     }
// }
// 
// Eigen::MatrixXf rdNumber=Rgener*mutCholDecomp;
// // rdNumber.colwise()+=meanVec;
// return Rcpp::List::create(Rcpp::Named("rdNul")=rdNumber);
// }