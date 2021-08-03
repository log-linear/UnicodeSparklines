.symbols <- list(
  bars = intToUtf8(seq(0x2581, 0x2588), multiple = T),
  lines = c("__", intToUtf8(seq(0x1fb7b, 0x1fb76), multiple = T), "⎺⎺")
)

#' Generate a sparkline from a vector of numbers
#'
#' @param numbers Vector of numbers.
#' @param return_range Logical. If \code{TRUE}, returns min and max values of
#'   input vector along with sparkline plot.
#' @param symbols Symbols used to create sparkline. Either \code{'lines'} or
#'   \code{'bars'}.
#' @return Sparkline plot as a character vector of length 1. Optionally includes
#'   min and max values per value of \code{return_range}.
#' @examples
#' test1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1)
#' test2 <- c(1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5)
#' sparkline(test1)
#' sparkline(test2)
sparkline <- function(numbers, return_range = F, symbols = c("bars", "lines")) {
  symbols <- .symbols[[match.arg(symbols)]]
  n_symbols <- length(symbols)
  mn <- min(numbers)
  mx <- max(numbers)
  interval <- mx - mn

  buckets <- sapply(
    numbers,
    function(i) {
      sym_idx <- 1 + min(n_symbols - 1,
                         floor((i - mn) / interval * n_symbols))
      symbols[[sym_idx]]
    }
  )
  sparkline <- paste0(buckets, collapse = "")

  if (return_range) return(c(mn, mx, sparkline))
  else return(sparkline)
}
