#' @name fit
#' @title Fits model to data
#' @description Generic function to fit models (inherited from \link{mlapiEstimator})
#' @param x A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}
#' @param model instance of class \code{estimator} which should implement method
#' with signature \code{$fit(x, y, ...)}
#' @param y \code{NULL} by default. Optional response variable for supervised learning models.
#' Should inherit from \code{vector} or \code{Matrix} or \code{matrix}. See documentation
#' for corresponding models.
#' @param ... additional data/model dependent arguments to downstream functions.
#' @return \code{invisible(object$self())}
#' @export
fit = function(x, model, y = NULL, ...) {
  UseMethod("fit")
}

#' @rdname fit
#' @export
fit.Matrix = function(x, model, y = NULL, ...) {
  stopifnot(inherits(model, "mlapiEstimator"))
  model$fit(x, y = y, ...)
}

#' @rdname fit
#' @export
fit.matrix = function(x, model, y = NULL, ...) {
  stopifnot(inherits(model, "mlapiEstimator"))
  model$fit(x, y = y, ...)
}

#' @name fit_transform
#' @title Fit model to the data, then transforms data
#' @description Generic function to fit transformers (inherits from \link{mlapiTransformer})
#' @param x A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}
#' @param model instance of class \code{estimator} which should implement method
#' with signature \code{$fit(x, ...)}
#' @param y \code{NULL} by default. Optional response variable for supervised models.
#' Should \bold{inherit from \code{vector} \code{Matrix} or \code{matrix}}.
#' See documentation for corresponding models.
#' @param ... additional data/model dependent arguments to downstream functions.
#' @return Transformed version of the \code{x}
#' @export
fit_transform = function(x, model, y = NULL, ...) {
  UseMethod("fit_transform")
}

#' @rdname fit_transform
#' @export
fit_transform.Matrix = function(x, model, y = NULL, ...) {
  stopifnot(inherits(model, "mlapiTransformer"))
  model$fit_transform(x, y = y, ...)
}

#' @rdname fit_transform
#' @export
fit_transform.matrix = function(x, model, y = NULL, ...) {
  stopifnot(inherits(model, "mlapiTransformer"))
  model$fit_transform(x, y = y, ...)
}

#' @name transform
#' @title Transforms new data using pre-trained model
#' @description Generic function to transform data with pre-trained \code{model} (inherits from \link{mlapiTransformer})
#' @export
#' @method transform Matrix
#' @param _data \bold{ = x} in other methods.
#' A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}
#' @param model object of class \code{mlapiTransformer} which
#' implements method \code{$transform(x, ...)}
#' @param ... additional data/model dependent arguments to downstream functions.
transform.Matrix = function(`_data`, model, ...) {
  stopifnot(inherits(model, "mlapiTransformer"))
  model$transform(`_data`, ...)
}

#' @rdname transform
#' @export
#' @method transform matrix
transform.matrix = function(`_data`, model, ...) {
  stopifnot(inherits(model, "mlapiTransformer"))
  model$transform(`_data`, ...)
}


#' @name predict
#' @title Makes predictions on new data using pre-trained model
#' @description Makes predictions on new data using pre-trained \code{model} (inherits from \link{mlapiEstimator})
#' @param object \bold{ = x} in other methods.
#' A matrix like object, should \bold{inherit from \code{Matrix} or \code{matrix}}
#' @param model object which \bold{inherits} class \link{mlapiEstimator} which
#' implements method \code{model$predict(x, ...)}
#' @param ... additional data/model dependent arguments to downstream functions
#' @export
#' @method predict matrix
predict.matrix = function(object, model, ...) {
  stopifnot(inherits(model, "mlapiEstimator"))
  model$predict(object, ...)
}

#' @rdname predict
#' @export
predict.Matrix = function(object, model, ...) {
  stopifnot(inherits(model, "mlapiEstimator"))
  model$predict(object, ...)
}
