#---------------------------------------------------------------------------------------
#' @name mlapiDecomposition
#'
#' @title Base abstract class for all decompositions
#' @description Base class for all \bold{decompositions} which are methods which can decompose matrix into
#' 2 low-dimensional matrices \code{x = f(A, B)}.
#' (Think of this Latent Dirichlet Allocation, Non-negative Matrix Factorization, etc).
#' It iherits from \link{mlapiTransformation} and additionally requires to implement \code{components} member.
#'
#' @format \code{R6Class} object.
#' @field components features embeddings. So if matrix is decomposed in a form \code{x = f(A, B)} where
#' X = n\*m, A = n\*k, B = k\*m them \code{B = components}
#' @section Methods:
#' \describe{
#'   \item{\code{$fit_transform(x, y = NULL, ...)}}{}
#'   \item{\code{$transform(x, ...)}}{Performs transformation of the new data (after model was trained)}
#'}
#' @section Arguments:
#' \describe{
#'  \item{x}{A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}.
#'  Allowed classes should be defined in child classes.}
#'  \item{y}{\code{NULL}. Optional taget variable. Usually this should be \code{NULL}.
#'  There few cases when it could be used.}
#'  \item{...}{additional parameters \bold{with default values}}
#' }
#' @examples
#' TruncatedSVD = R6::R6Class(
#'   classname = "TruncatedSVD",
#'   inherit = mlapi::mlapiDecomposition,
#'   public = list(
#'     initialize = function(rank = 10) {
#'       private$rank = rank
#'       super$set_internal_matrix_formats(dense = "matrix", sparse = NULL)
#'     },
#'     fit_transform = function(x, ...) {
#'       x = super$check_convert_input(x)
#'       private$n_features = ncol(x)
#'       svd_fit = svd(x, nu = private$rank, nv = private$rank, ...)
#'       sing_values = svd_fit$d[seq_len(private$rank)]
#'       result = svd_fit$u %*% diag(x = sqrt(sing_values))
#'       private$components_ = t(svd_fit$v %*% diag(x = sqrt(sing_values)))
#'       rm(svd_fit)
#'       rownames(result) = rownames(x)
#'       colnames(private$components_) = colnames(x)
#'       private$fitted = TRUE
#'       invisible(result)
#'     },
#'     transform = function(x, ...) {
#'       if (private$fitted) {
#'         stopifnot(ncol(x) == ncol(private$components_))
#'         lhs = tcrossprod(private$components_)
#'         rhs = as.matrix(tcrossprod(private$components_, x))
#'         t(solve(lhs, rhs))
#'       }
#'       else
#'         stop("Fit the model first woth model$fit_transform()!")
#'     }
#'   ),
#'   private = list(
#'     rank = NULL,
#'     n_features = NULL,
#'     fitted = NULL
#'   )
#' )
#' set.seed(1)
#' model = TruncatedSVD$new(2)
#' x = matrix(sample(100 * 10, replace = TRUE), ncol = 10)
#' x_trunc = model$fit_transform(x)
#' dim(x_trunc)
#'
#' x_trunc_2 = model$transform(x)
#' sum(x_trunc_2 - x_trunc)
#'
#' #' check pipe-compatible S3 interface
#' x_trunc_2_s3 = transform(x, model)
#' identical(x_trunc_2, x_trunc_2_s3)
#' @export
mlapiDecomposition = R6::R6Class(
  classname = "mlapiDecomposition",
  inherit = mlapiTransformation,
  active = list(
    # make components read only via active bindings
    components = function(value) {
      if (!missing(value))
        # In "setter" role
        stop("Sorry this is a read-only variable.")
      else {
        # In "getter" role
        if(is.null(private$components_)) {
          warning("Decomposition model was not fitted yet!")
          NULL
        }
        else
          private$components_
      }
    }
  ),
  private = list(
    components_ = NULL
  )
)
#---------------------------------------------------------------------------------------
#' @name mlapiDecomposition
#'
#' @title Base abstract class for all incremental decompositions
#' @description Base class for all \bold{decompositions} which are methods which can decompose matrix into
#' 2 low-dimensional matrices \code{x = f(A, B)} \bold{incrementally}.
#' It iherits from \link{mlapiDecomposition} and additionally requires
#' to implement \code{partial_fit} method which can learn \code{components} incrementally.
#'
#' @format \code{R6Class} object.
#' @field components features embeddings. So if matrix is decomposed in a form \code{x = f(A, B)} where
#' X = n\*m, A = n\*k, B = k\*m them \code{B = components}
#' @section Methods:
#' \describe{
#'   \item{\code{$fit_transform(x, y = NULL, ...)}}{}
#'   \item{\code{$partial_fit(x, y = NULL, ...)}}{}
#'   \item{\code{$transform(x, ...)}}{Performs transformation of the new data (after model was trained)}
#'}
#' @section Arguments:
#' \describe{
#'  \item{x}{A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}.
#'  Allowed classes should be defined in child classes.}
#'  \item{y}{\code{NULL}. Optional taget variable. Usually this should be \code{NULL}.
#'  There few cases when it could be used.}
#'  \item{...}{additional parameters \bold{with default values}}
#' }
#' @export
mlapiDecompositionOnline <- R6::R6Class(
  classname = "mlapiDecompositionOnline",
  inherit = mlapiDecomposition,
  public = list(
    partial_fit = function(x, y = NULL, ...) raise_placeholder_error()
  )
)
