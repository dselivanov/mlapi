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
    # has to dump inpternal model representation to R object in order to be able to load it in future
    # for example internally model can keep data out of R's heap and have external pointer to it
    # dump = function() raise_placeholder_error(),
    # load data from dump to internal representation - ie load data to internal out of heap data structures
    # load = function(model) raise_placeholder_error()
  )
)
