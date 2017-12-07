#' @name mlapiTransformation
#'
#' @title Base abstract class for all transformations
#' @description Base class for all online transformations.
#' @format \code{R6Class} object.
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
mlapiTransformation = R6::R6Class(
  classname = "mlapiTransformation",
  inherit = mlapiBase,
  public = list(
    fit_transform = function(x, y = NULL, ...) raise_placeholder_error(),
    transform = function(x, y = NULL, ...) raise_placeholder_error()
  )
)
#---------------------------------------------------------------------------------------
#' @name mlapiTransformationOnline
#'
#' @title Base abstract class for all transformations
#' which can be \bold{trained incremendally} (online)
#' @description Base class for all online transformations. This class inherits from \link{mlapiTransformation} and
#' additionally requires to implement \code{$partial_fit(x, y, ...)} method. Idea is that user can pass
#' \code{x, y} in chunks and model will be updated/refined incrementally.
#' @format \code{R6Class} object.
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
mlapiTransformationOnline <- R6::R6Class(
  classname = "mlapiTransformationOnline",
  inherit = mlapiTransformation,
  public = list(
    partial_fit = function(x, y = NULL, ...) raise_placeholder_error()
  )
)
