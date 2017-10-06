mlapiBase = R6::R6Class(
  classname = "mlapiBase",
  private = list(
    #-------------------------------------------------------------------------------------
    internal_matrix_formats = list(sparse = NULL, dense = NULL),
    #-------------------------------------------------------------------------------------
    set_internal_matrix_formats = function(sparse = NULL, dense = NULL) {

      stopifnot(is.character(sparse) || is.null(sparse))
      stopifnot(length(sparse) <= 1)

      stopifnot(is.character(dense) || is.null(dense))
      stopifnot(length(dense) <= 1)

      private$internal_matrix_formats = list(sparse = sparse, dense = dense)
    },
    #-------------------------------------------------------------------------------------
    check_convert_input = function(x) {
      stopifnot(all(names(private$internal_matrix_formats) %in% c("dense", "sparse")))

      # first check sparse input
      if(inherits(x, "sparseMatrix")) {
        sparse_format = private$internal_matrix_formats[["sparse"]]
        if(is.null(sparse_format))
          stop("input inherits from 'sparseMatrix', but underlying functions don't work with SPARSE matrices")
        return(as(x, sparse_format))
      }
      # them check dense formats
      else {
        dense_format = private$internal_matrix_formats[["dense"]]
        if(is.null(dense_format))
          stop(sprintf("don't know how to deal with input of class '%s'", paste(class(x), collapse = " | ") ))
        return(as(x, dense_format))
      }
    }
    #-------------------------------------------------------------------------------------
  )
)
